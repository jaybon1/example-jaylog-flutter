import 'package:dio/dio.dart';
import 'package:jaylog/util/custom.dart';

class MainRepository {
  static const _url = '/v1/main';

  static Future<Response> get(String searchValue) async {
    return await CustomFetch.dioWithJwt.get(
      searchValue.isEmpty ? _url : '$_url?searchValue=$searchValue',
    );
  }
}
