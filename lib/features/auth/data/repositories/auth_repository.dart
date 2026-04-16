import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static const String keyIsLoggedIn = 'isLoggedIn';
  static const String keyUserEmail = 'userEmail';

  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // UX Mock delay mapping realism structurally
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyIsLoggedIn, true);
    await prefs.setString(keyUserEmail, email);
  }

  Future<void> signup(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyIsLoggedIn, true);
    await prefs.setString(keyUserEmail, email);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyIsLoggedIn);
    await prefs.remove(keyUserEmail);
  }

  Future<bool> checkLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsLoggedIn) ?? false;
  }

  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyUserEmail);
  }
}
