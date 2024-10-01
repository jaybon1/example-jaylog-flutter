import 'package:dio/dio.dart';
import 'package:jaylog/model/auth/dto/req/req_auth_post_login_dto.dart';
import 'package:jaylog/util/custom.dart';

class AuthRepository {
  static const _url = '/auth';

  // static Future<Response> login(ReqAuthPostLoginDTO reqAuthPostLoginDTO) async {
  //   return await CustomFetch.dio.post("$_url/login", data: reqAuthPostLoginDTO);
  // }

  static Future<Response> login(ReqAuthPostLoginDTO reqAuthPostLoginDTO) async {
    return await CustomFetch.dio.post("$_url/login", data: reqAuthPostLoginDTO);
  }
}
