import 'package:dio/dio.dart';
import 'package:jaylog/common/constant/constant.dart';
import 'package:jaylog/model/auth/dto/req/req_auth_post_refresh_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomFetch {
  static final Dio dio = Dio()..options.baseUrl = Constant.baseUrl;

  static final Dio dioWithJwt = Dio()
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
      }
      try {
        Response responseOfRefresh = await CustomFetch.dio.post(
          '/auth/refresh',
          data: ReqAuthPostRefreshDTO.of(refreshJwt: refreshJwt).toMap(),
          options: Options(
            contentType: Headers.jsonContentType,
          ),
        );
        if (responseOfRefresh.statusCode == 200) {
          sharedPreferences.setString(
              "accessJwt", responseOfRefresh.data['data']['accessJwt']);
          sharedPreferences.setString(
              "refreshJwt", responseOfRefresh.data['data']['refreshJwt']);
          final RequestOptions requestOptions = err.requestOptions;
          requestOptions.headers['Authorization'] =
              'Bearer ${responseOfRefresh.data['data']['accessJwt']}';
          // final responseOfRetry = await CustomFetch.dio.request(
          //   requestOptions.path,
          //   options: Options(
          //     method: requestOptions.method,
          //     headers: requestOptions.headers,
          //   ),
          //   data: requestOptions.data,
          //   queryParameters: requestOptions.queryParameters,
          // );
          final responseOfRetry = await CustomFetch.dio.fetch(requestOptions);
          handler.resolve(responseOfRetry);
          return;
        }
      } catch (e) {
        sharedPreferences.remove("accessJwt");
        sharedPreferences.remove("refreshJwt");
        handler.reject(err);
        return;
      }
    } else {
      super.onError(err, handler);
    }
  }
}
