class ReqAuthPostJoinDTO {
  final _User user;

  ReqAuthPostJoinDTO._({required this.user});

  factory ReqAuthPostJoinDTO.of(
      {required String username,
      required String password,
      String? simpleDescription}) {
    return ReqAuthPostJoinDTO._(
      user: _User(
        username: username,
        password: password,
        simpleDescription: simpleDescription,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': {
        'username': user.username,
        'password': user.password,
        'simpleDescription': user.simpleDescription,
      },
    };
  }
}

class _User {
  final String username;
  final String password;
  final String? simpleDescription;

  _User(
      {required this.username, required this.password, this.simpleDescription});
}
