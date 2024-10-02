import 'dart:async';

import 'package:dio/dio.dart';

class UtilFunction {
  static FutureOr<Null> handleDefaultError(error, stackTrace) {
    if (error is DioException && error.response?.data != null) {
      print(error.response?.data["message"]);
    } else {
      print("예상치 못한 에러가 발생했습니다.\n관리자에게 문의하세요.\n$error");
    }
  }
}
