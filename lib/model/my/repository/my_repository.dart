import 'package:dio/dio.dart';
import 'package:jaylog/util/custom.dart';

class MyRepository {
  static const _url = '/my';

  static Future<Response> get() async {
    return await CustomFetch.dio.get("$_url");
  }

  static Future<Response> putInfo(FormData formData) async {
    return await CustomFetch.dio.put(
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
