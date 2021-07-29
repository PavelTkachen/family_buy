import 'package:family_buy/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final Map user;
  HomeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(user['name']),
            Text(user['email']),
            ElevatedButton(
                onPressed: () {
                  context.read<LoginProvider>().logout();
                },
                child: Text("Выход"))
          ],
        ),
      ),
    );
  }
}
