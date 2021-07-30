import 'package:family_buy/forms/login_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Страница авторизации"),
      ),
      body: Center(child: LoginForm()),
    );
  }
}
