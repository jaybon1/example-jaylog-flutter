import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authStoreGlobal = ChangeNotifierProvider<AuthStore>((ref) {
  return AuthStore();
});

class AuthStore extends ChangeNotifier {
  LoginUser? _loginUser;

  LoginUser? get loginUser => _loginUser;

  void setLoginUser(LoginUser loginUser) {
    _loginUser = loginUser;
    notifyListeners();
  }
}

class LoginUser {
  final String name;
  final String simpleDescription;
  final String profileImage;
  final List<String> roleList;

  LoginUser({
    required this.name,
    required this.simpleDescription,
    required this.profileImage,
    required this.roleList,
  });
}
