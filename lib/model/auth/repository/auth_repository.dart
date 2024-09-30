
import 'dart:convert';

import 'package:jaylog/common/dto/res_dto.dart';
import 'package:jaylog/constant/constant.dart';
import 'package:jaylog/model/auth/dto/req/req_auth_post_login_dto.dart';
import 'package:jaylog/model/auth/dto/res/res_auth_post_login_dto.dart';

class AuthRepository {
  static const _url = '/auth';

  static Future<ResDTO<ResAuthPostLoginDTO?>> login(ReqAuthPostLoginDTO reqAuthPostLoginDTO) async {
    return ResDTO(code: 0, message: "message");
  }

}