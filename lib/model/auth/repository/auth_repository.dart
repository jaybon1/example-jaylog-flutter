import 'package:dio/dio.dart';
import 'package:jaylog/model/auth/dto/req/req_auth_post_join_dto.dart';
import 'package:jaylog/model/auth/dto/req/req_auth_post_login_dto.dart';
import 'package:jaylog/model/auth/dto/req/req_auth_post_refresh_dto.dart';
import 'package:jaylog/util/custom.dart';

class AuthRepository {
  static const _url = '/auth';

  static Future<Response> postJoin(ReqAuthPostJoinDTO reqAuthPostJoinDTO) async {
    return await CustomFetch.dio.post("$_url/join", data: reqAuthPostJoinDTO);
  }

  static Future<Response> postLogin(ReqAuthPostLoginDTO reqAuthPostLoginDTO) async {
    return await CustomFetch.dio.post("$_url/login", data: reqAuthPostLoginDTO);
  }

  static Future<Response> postRefresh(ReqAuthPostRefreshDTO reqAuthPostRefreshDTO) async {
    return await CustomFetch.dio.post("$_url/login", data: reqAuthPostRefreshDTO);
  }
}
