import 'dart:async';
import 'package:family_buy/api/login.dart';
import 'package:family_buy/enums/login.dart';
import 'package:family_buy/models/response_model.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  AppState _appState = AppState.initial;
  Map _user = {"name": "Pavel"};
  String? _error;

  //getters
  AppState get appState => _appState;
  Map get user => _user;
  String? get error => _error;

  LoginProvider.instance() {
    // check user auth with init app
    initialize();
  }
  Future<void> initialize() async {
    Response response = await checkAuth();
    _error = response.body.getError();
    if (error == null) {
      _appState = AppState.auth;
    } else {
      _appState = AppState.unauth;
    }
    notifyListeners();
  }

  // signUp
  Future<void> signUp(String email, String password) async {}

  // signIn
  Future<bool> signIn(String email, String password) async {
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

  // signOut
  Future<bool> signOut() async {
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
