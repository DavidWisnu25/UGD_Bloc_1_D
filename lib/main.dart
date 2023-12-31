import 'package:flutter/material.dart';
import 'package:ugd_bloc/page/login_page.dart';
import 'package:ugd_bloc/page/register_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
      },
    );
  }
}
