import 'package:flutter/material.dart';
import 'package:fluttter_authentication/repository/auth_repositories.dart';
import 'package:fluttter_authentication/screens/auth/login_form.dart';

class LoginScreen extends StatelessWidget {
  final AuthRepositories _authRepositories;
  const LoginScreen({Key? key, required AuthRepositories authRepositories})
      : _authRepositories = authRepositories,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginForm(
        authRepositories: _authRepositories,
      ),
    );
  }
}
