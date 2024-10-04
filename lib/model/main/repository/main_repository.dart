
import 'package:dio/dio.dart';
import 'package:jaylog/util/custom.dart';

class MainRepository {
  static const _url = '/main';

  static Future<Response> get(String searchValue) async {
    return await CustomFetch.dio.get("$_url?searchValue=$searchValue");
  }
}
