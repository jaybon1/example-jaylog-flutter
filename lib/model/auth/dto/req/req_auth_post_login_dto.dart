
class ReqAuthPostLoginDTO {
  final String username;
  final String password;

  ReqAuthPostLoginDTO({
    required this.username,
    required this.password,
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     'username': username,
  //     'password': password,
  //   };
  // }

}