import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/model/auth/dto/req/req_auth_post_login_dto.dart';
import 'package:jaylog/model/auth/repository/auth_repository.dart';
import 'package:jaylog/util/util_function.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authLoginViewModelLocal =
    ChangeNotifierProvider.autoDispose<_AuthLoginViewModel>((ref) {
  return _AuthLoginViewModel();
});

class _AuthLoginViewModel extends ChangeNotifier {
  bool _isPendingLogin = false;

  bool get isPendingLogin => _isPendingLogin;

  Future<void> postLogin({
    required ReqAuthPostLoginDTO reqAuthPostLoginDTO,
    required Function onSuccess,
    Function onError = UtilFunction.handleDefaultError,
  }) async {
    _isPendingLogin = true;
    notifyListeners();
    try {
      final response = await AuthRepository.postLogin(reqAuthPostLoginDTO);
      final sharedPreferences = await SharedPreferences.getInstance();
      final resDTO = response.data;
      sharedPreferences.setString("accessJwt", resDTO["data"]["accessJwt"]);
      sharedPreferences.setString("refreshJwt", resDTO["data"]["refreshJwt"]);
      onSuccess(resDTO["message"]);
    } on Exception catch (e, stackTrace) {
      onError(e, stackTrace);
    } finally {
      _isPendingLogin = false;
      notifyListeners();
    }
  }
}
