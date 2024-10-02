
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/model/auth/dto/req/req_auth_post_join_dto.dart';
import 'package:jaylog/model/auth/dto/req/req_auth_post_login_dto.dart';
import 'package:jaylog/model/auth/repository/auth_repository.dart';
import 'package:jaylog/util/util_function.dart';

final authLoginViewModelLocal = ChangeNotifierProvider.autoDispose<_AuthLoginViewModel>((ref) {
  return _AuthLoginViewModel();
});

class _AuthLoginViewModel extends ChangeNotifier {
  bool _isPendingLogin = false;

  bool get isPendingLogin => _isPendingLogin;

  void postLogin(ReqAuthPostLoginDTO reqAuthPostLoginDTO) {
    _isPendingLogin = true;
    notifyListeners();
    AuthRepository.postLogin(reqAuthPostLoginDTO)
    .then((response) {
      // 성공 시 처리
    })
    .onError(UtilFunction.handleDefaultError)
    .whenComplete(() {
      _isPendingLogin = false;
      notifyListeners();
    });
  }
}