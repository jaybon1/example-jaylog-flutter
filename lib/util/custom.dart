import 'package:dio/dio.dart';
import 'package:jaylog/constant/constant.dart';
import 'package:jaylog/model/auth/dto/req/req_auth_post_refresh_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomFetch {
  // static Future<http.Response> get(String url,
  //     {Map<String, String>? headers}) async {
  //   Future<http.Response> request = http.get(
  //     getCustomUrlWith(url),
  //     headers: await getCustomHeadersWith(headers),
  //   );
  //
  //   return ;
  // }
  //
  // static Future<http.Response> post(String url,
  //     {Map<String, String>? headers, dynamic body}) async {
  //   return await http.post(
  //     getCustomUrlWith(url),
  //     headers: await getCustomHeadersWith(headers),
  //     body: body != null ? jsonEncode(body) : null,
  //   );
  // }
  //
  // static Future<http.Response> put(String url,
  //     {Map<String, String>? headers, dynamic body}) async {
  //   return await http.put(
  //     getCustomUrlWith(url),
  //     headers: await getCustomHeadersWith(headers),
  //     body: body != null ? jsonEncode(body) : null,
  //   );
  // }
  //
  // static Future<http.Response> delete(String url,
  //     {Map<String, String>? headers}) async {
  //   return await http.delete(
  //     getCustomUrlWith(url),
  //     headers: await getCustomHeadersWith(headers),
  //   );
  // }
  //
  static String getCustomUrlWith(String url) {
    String customUrl;
    if (url.startsWith("http")) {
      customUrl = url;
    } else {
      customUrl = "${Constant.baseUrl}$url";
    }
    return customUrl;
  }

  static Future<Map<String, dynamic>> getCustomHeadersWith(
      Map<String, dynamic>? headers) async {
    Map<String, dynamic> customHeaders = {
      "Content-Type": "application/json",
    };
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessJwt = sharedPreferences.getString("accessJwt");
    if (accessJwt != null) {
      customHeaders.addAll({
        "Authorization": "Bearer $accessJwt",
      });
    }
    if (headers != null) {
      customHeaders.addAll(headers);
    }
    return customHeaders;
  }
//
// static Future<http.Response> handleCustomFetchResponse(
//     http.Response response, String url,
//     {Map<String, String>? headers, dynamic body}) async {
//
//
//
//   return response;
// }

// static Future<ResDTO<T>> handleResponse<T>(http.Response response,
//     {Function? handleData}) async {
//   if (response.statusCode == 200) {
//     final Map<String, dynamic> decodedResponseBody =
//         jsonDecode(response.body);
//     return ResDTO<T>(
//       code: decodedResponseBody["code"],
//       message: decodedResponseBody["message"],
//       data:
//           handleData != null ? handleData(decodedResponseBody["data"]) : null,
//     );
//   } else if (response.body.isNotEmpty) {
//     final Map<String, dynamic> decodedResponseBody =
//         jsonDecode(response.body);
//     final resDto = ResDTO<T>(
//       code: decodedResponseBody["code"],
//       message: "${decodedResponseBody["message"]}\n\n${response.body}",
//     );
//     if (response.statusCode == 401) {
//       return resDto;
//     } else if (response.statusCode == 403) {
//       return resDto;
//     } else if (response.statusCode == 400) {
//       return resDto;
//     } else if (response.statusCode == 500) {
//       return resDto;
//     } else {
//       return resDto;
//     }
//   } else {
//     return ResDTO<T>(
//       code: -99,
//       message: "통신 에러",
//     );
//   }
// }
}

class CustomDioInterceptor extends Interceptor {
  final Dio _dio = Dio();

  @override
  void onRequest(RequestOptions options,
      RequestInterceptorHandler handler) async {
    options.baseUrl = Constant.baseUrl;
    options.headers = await CustomFetch.getCustomHeadersWith(options.headers);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String? refreshJwt = sharedPreferences.getString("refreshJwt");
      if(refreshJwt == null) {
        return handler.reject(err);
      }
      try {
        Response responseOfRefresh = await _dio.post(
            '${Constant.baseUrl}/auth/refresh',
            data: ReqAuthPostRefreshDTO.of(refreshJwt),
            options: Options(
              contentType: Headers.jsonContentType,
            )
        );
        if (responseOfRefresh.statusCode == 200) {
          sharedPreferences.setString("accessJwt", responseOfRefresh.data['data']['accessJwt']);
          sharedPreferences.setString("refreshJwt", responseOfRefresh.data['data']['refreshJwt']);
          final RequestOptions requestOptions = err.requestOptions;
          requestOptions.headers['Authorization'] = 'Bearer ${responseOfRefresh.data['data']['accessJwt']}';
          final responseOfRetry = await _dio.request(
            requestOptions.path,
            options: Options(
              method: requestOptions.method,
              headers: requestOptions.headers,
            ),
            data: requestOptions.data,
            queryParameters: requestOptions.queryParameters,
          );
          return handler.resolve(responseOfRetry);
        }
      } catch (e) {
        sharedPreferences.remove("accessJwt");
        sharedPreferences.remove("refreshJwt");
        // authStore 로그아웃 처리
        return handler.reject(err);
      }
    }
    super.onError(err, handler);
  }
}
