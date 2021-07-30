import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:family_buy/forms/login_form.dart';
import 'package:family_buy/providers/login_provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final error = context.watch<LoginProvider>().error;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Ошибка авторизации: $error'),
      ));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Страница авторизации"),
      ),
      body: Center(child: LoginForm()),
    );
  }
}
