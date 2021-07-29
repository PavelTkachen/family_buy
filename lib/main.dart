import 'package:family_buy/providers/login_provider.dart';
import 'package:family_buy/screens/home_screen.dart';
import 'package:family_buy/screens/login_screen.dart';
import 'package:family_buy/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'enums/login.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginProvider.instance())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Семейные покупки",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppStarted(context: context),
    );
  }
}

class AppStarted extends StatelessWidget {
  final BuildContext context;
  AppStarted({required this.context});

  @override
  Widget build(BuildContext context) {
    switch (context.watch<LoginProvider>().appState) {
      case AppState.authenticating:
      case AppState.unauth:
        return LoginScreen();
      case AppState.initial:
        return SplashScreen();
      case AppState.auth:
        return HomeScreen(user: context.watch<LoginProvider>().user);
    }
  }
}
