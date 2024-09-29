
class AuthRepository {

  Future<bool> login(String email, String password) async {


    // Simulate a network request
    await Future.delayed(Duration(seconds: 1));
    return email == '';
  }

}