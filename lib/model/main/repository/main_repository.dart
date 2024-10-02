
import 'package:dio/dio.dart';
import 'package:jaylog/common/dto/res_dto.dart';
import 'package:jaylog/model/main/dto/res/res_main_get_dto.dart';
import 'package:jaylog/util/custom.dart';

class MainRepository {
  static const _url = '/main';

  static Future<Response> get(String searchValue) async {
    return await CustomFetch.dio.get("$_url?searchValue=$searchValue");
  }
}
