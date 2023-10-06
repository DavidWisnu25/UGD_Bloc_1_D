import 'package:ugd_bloc/model/globalData.dart';

import '../model/user.dart';

class FailedRegister implements Exception {
  String errorMessage() {
    return "Register Failed";
  }
}

class RegisterRepository {
  Future<User> register(String username, String password, String email,
      String noTelpon, String selectedDate) async {
    User userData = User();
    await Future.delayed(Duration(seconds: 3), () {
      if (username.isEmpty || password.isEmpty) {
        throw 'Username or password cannot be empty';
      } else if (username.isNotEmpty && password.isNotEmpty) {
        userData = User(name: username, password: password, token: "12345");
        globalData.listUsers.add(userData);
      }
    });
    return userData;
  }
}
