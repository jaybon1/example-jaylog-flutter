class ReqAuthPostLoginDTO {
  final _User user;

  ReqAuthPostLoginDTO._({required this.user});

  factory ReqAuthPostLoginDTO.of({required String username, required String password}) {
    return ReqAuthPostLoginDTO._(
      user: _User(
        username: username,
        password: password,
      ),
    );
  }
}

class _User {
  final String username;
  final String password;

  _User({required this.username, required this.password});
}
