import 'dart:async';

import 'package:family_buy/enums/login.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  AppState _appState = AppState.initial;
  Map _user = {"name": "Pavel"};
  AppState get appState => _appState;
  Map get user => _user;

  // FAKE_DATA
  bool mokeAuth = false;

  LoginProvider.instance() {
    // check user auth with init app(fake request with duration)
    Future.delayed(Duration(seconds: 2), initialize);
  }
  void initialize() {
    if (mokeAuth) {
      _appState = AppState.auth;
    } else {
      _appState = AppState.unauth;
    }
    notifyListeners();
  }

  // login
  Future<bool> login(String email, String password) async {
    try {
      _appState = AppState.authenticating;
      // api request for login (api/login)
      _appState = AppState.auth;
      _user = {..._user, 'email': email};
      notifyListeners();
      return true;
    } catch (e) {
      _appState = AppState.unauth;
      notifyListeners();
      return false;
    }
  }

  // logout
  Future<bool> logout() async {
    try {
      // api request for logout (api/logout)
      _appState = AppState.unauth;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
