import 'package:dio/dio.dart';
import 'package:jaylog/util/custom.dart';

class MyRepository {
  static const _url = '/v1/my';

  static Future<Response> get() async {
    return await CustomFetch.dioWithJwt.get("$_url");
  }

  static Future<Response> putInfo(FormData formData) async {
    return await CustomFetch.dioWithJwt.put(
      "$_url/info",
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
  }
}
