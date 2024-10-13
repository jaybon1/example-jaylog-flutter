class ReqAuthPostLoginDTO {
  final _User user;

  ReqAuthPostLoginDTO._({required this.user});

  factory ReqAuthPostLoginDTO.of(
      {required String username, required String password}) {
    return ReqAuthPostLoginDTO._(
      user: _User(
        username: username,
        password: password,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': {
        'username': user.username,
        'password': user.password,
      },
    };
  }
}

class _User {
  final String username;
  final String password;

  _User({required this.username, required this.password});
}
