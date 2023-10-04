class User {
  final String? name;
  final String? password;
  final String? token;

  User({this.name, this.password, this.token});

  @override
  String toString() {
    return 'User{name: $name, password: $password, token: $token}';
  }
}
