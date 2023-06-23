import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String _username = '';

  bool get isAuthenticated => _isAuthenticated;
  String get username => _username;

  AuthProvider._();

  static final AuthProvider _instance = AuthProvider._();

  factory AuthProvider() {
    return _instance;
  }

  static AuthProvider get instance => _instance;

  Future<void> login(String username) async {
    if (username.isEmpty) {
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setBool('isAuthenticated', true);

    _isAuthenticated = true;
    _username = username;
    notifyListeners();
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('isAuthenticated');

    _isAuthenticated = false;
    _username = '';
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
    _username = prefs.getString('username') ?? '';
    notifyListeners();
  }
}
