import 'package:ugd_bloc/model/globalData.dart';

import '../model/user.dart';

class FailedLogin implements Exception {
  String errorMessage() {
    return "Login Failed";
  }
}

class LoginRepository {

  Future<User> login(String username, String password) async {
    User userData = User(name: "", password: "");
    await Future.delayed(Duration(seconds: 1), () {
      if (username == '' || password == '') {
        throw 'Username or Password cannot be empty';
      }
      for (User user in globalData.listUsers) {
        if (user.name == username && user.password == password) {
          userData = user;
          break;
        }
      }
      if (userData.name == '' || userData.password == '') {
        throw FailedLogin();
      }
    });
    return userData;
  }
}
