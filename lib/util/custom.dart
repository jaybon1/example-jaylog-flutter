import 'package:dio/dio.dart';
import 'package:jaylog/constant/constant.dart';
import 'package:jaylog/model/auth/dto/req/req_auth_post_refresh_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomFetch {
  static final Dio dio = Dio()
    ..options.baseUrl = Constant.baseUrl
    ..interceptors.add(CustomDioInterceptor());

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
}

class CustomDioInterceptor extends Interceptor {
  final Dio _dio = Dio();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
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
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? refreshJwt = sharedPreferences.getString("refreshJwt");
      if (refreshJwt == null) {
        handler.reject(err);
        return;
        // return handler.reject(err);
      }
      try {
        Response responseOfRefresh =
            await _dio.post('${Constant.baseUrl}/auth/refresh',
                data: ReqAuthPostRefreshDTO.of(refreshJwt: refreshJwt),
                options: Options(
                  contentType: Headers.jsonContentType,
                ));
        if (responseOfRefresh.statusCode == 200) {
          sharedPreferences.setString(
              "accessJwt", responseOfRefresh.data['data']['accessJwt']);
          sharedPreferences.setString(
              "refreshJwt", responseOfRefresh.data['data']['refreshJwt']);
          final RequestOptions requestOptions = err.requestOptions;
          requestOptions.headers['Authorization'] =
              'Bearer ${responseOfRefresh.data['data']['accessJwt']}';
          final responseOfRetry = await _dio.request(
            requestOptions.path,
            options: Options(
              method: requestOptions.method,
              headers: requestOptions.headers,
            ),
            data: requestOptions.data,
            queryParameters: requestOptions.queryParameters,
          );
          handler.resolve(responseOfRetry);
          // return handler.resolve(responseOfRetry);
        }
      } catch (e) {
        sharedPreferences.remove("accessJwt");
        sharedPreferences.remove("refreshJwt");
        // authStore 로그아웃 처리
        handler.reject(err);
        return;
        // return handler.reject(err);
      }
    } else {
      super.onError(err, handler);
    }
  }
}
