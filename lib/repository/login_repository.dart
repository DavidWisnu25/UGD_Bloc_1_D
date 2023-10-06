import '../model/user.dart';
import 'register_repository.dart';

class FailedLogin implements Exception {
  String errorMessage() {
    return "Login Failed";
  }
}

class LoginRepository {
  List<User> data = RegisterRepository.data;

  Future<User> login(String username, String password) async {
    User userData = User();
    await Future.delayed(const Duration(seconds: 3), () {
      for (User temp in data) {
        if (temp.name == username && temp.password == password) {
          userData = temp;
          return userData;
        }
      }
      throw FailedLogin();
    });
    return userData;
  }
}
