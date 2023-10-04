import '../model/user.dart';

class FailedLogin implements Exception {
  String errorMessage() {
    return "Login Failed";
  }
}

class LoginRepository {
  String username = "User";
  String password = "123";

  Future<User> login(String username, String password) async {
    User userData = User();
    await Future.delayed(Duration(seconds: 3), () {
      if (this.username == username && this.password == password) {
        userData = User(name: username, password: password, token: "12345");
      } else if (username == '' || password == '') {
        throw 'Username or password cannot be empty';
      } else {
        throw FailedLogin();
      }
    });
    return userData;
  }
}
