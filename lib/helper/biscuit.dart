import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:cashier_app_mobile/helper/app_exception.dart';
import 'package:cashier_app_mobile/model/user.dart';

class Biscuit {
  Future saveUser(User login) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map loginMap = login.toMap();
    String jsonBody = json.encode(loginMap);

    await prefs.setString('Login', jsonBody);
  }

  Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User? log;
    try {
      String? jsonBody = prefs.getString('Login');
      if (jsonBody != null) {
        final map = json.decode(jsonBody) as Map<String, dynamic>;
        log = User.map(map);
      }
    } catch (e) {
      throw InvalidSessionExpression('Session is Expired');
    }

    return log;
  }

  Future dbClear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
