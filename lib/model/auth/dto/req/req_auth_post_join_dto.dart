class ReqAuthPostJoinDTO {
  final _User user;

  ReqAuthPostJoinDTO._({required this.user});

  factory ReqAuthPostJoinDTO.of({required String username, required String password}) {
    return ReqAuthPostJoinDTO._(
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
