import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authStoreGlobal = ChangeNotifierProvider<AuthStore>((ref) {
  return AuthStore();
  // return AuthStore.of(
  //   loginUser: LoginUser(
  //     name: "Jay",
  //     simpleDescription: "Flutter Developer",
  //     profileImage: "https://picsum.photos/50",
  //     roleList: ["admin", "user"],
  //   ),
  // );
});

class AuthStore extends ChangeNotifier {
  LoginUser? _loginUser;

  LoginUser? get loginUser => _loginUser;

  // AuthStore.of({LoginUser? loginUser}) {
  //   _loginUser = loginUser;
  // }

  void setLoginUser(LoginUser loginUser) {
    _loginUser = loginUser;
    notifyListeners();
  }

  void logout() {
    _loginUser = null;
    notifyListeners();
  }
}

class LoginUser {
  final String username;
  final String simpleDescription;
  final String profileImage;
  final List<String> roleList;

  LoginUser({
    required this.username,
    required this.simpleDescription,
    required this.profileImage,
    required this.roleList,
  });
}
