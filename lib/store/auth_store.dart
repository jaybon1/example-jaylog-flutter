import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authStoreGlobal = ChangeNotifierProvider<AuthStore>((ref) {
  return AuthStore();
});

class AuthStore extends ChangeNotifier {
  LoginUser? _loginUser;

  LoginUser? get loginUser => _loginUser;

  Future<void> setLoginUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final accessJwt = sharedPreferences.getString("accessJwt");
    if (accessJwt == null || JwtDecoder.isExpired(accessJwt)) {
      sharedPreferences.remove("accessJwt");
      sharedPreferences.remove("refreshJwt");
      _loginUser = null;
      return;
    }
    final Map<String, dynamic> decodedToken = JwtDecoder.decode(accessJwt);
    _loginUser = LoginUser(
      username: decodedToken["username"] as String,
      simpleDescription: decodedToken["simpleDescription"] as String?,
      profileImage: decodedToken["profileImage"] as String,
      roleList: [...decodedToken["roleList"]],
    );
    notifyListeners();
  }

  void logout() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("accessJwt");
    sharedPreferences.remove("refreshJwt");
    _loginUser = null;
    notifyListeners();
  }
}

class LoginUser {
  final String username;
  final String? simpleDescription;
  final String profileImage;
  final List<String> roleList;

  LoginUser({
    required this.username,
    required this.simpleDescription,
    required this.profileImage,
    required this.roleList,
  });
}
