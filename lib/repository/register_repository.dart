import '../model/user.dart';

class FailedRegister implements Exception {
  String errorMessage() {
    return "Register Failed";
  }
}

class RegisterRepository {
  static List<User> data = [];

  Future<User> register(String username, String password) async {
    User userData = User();
    await Future.delayed(const Duration(seconds: 3), () {
      if (username.isNotEmpty && password.isNotEmpty) {
        userData = User(name: username, password: password, token: "12345");
        data.add(userData);
      } else if (username == '' || password == '') {
        throw 'Username or password cannot be empty';
      } else {
        throw FailedRegister();
      }
    });
    return userData;
  }
}
