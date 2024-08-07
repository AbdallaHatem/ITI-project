import 'package:shared_preferences/shared_preferences.dart';

class sharedPref {
  static bool islogged = false;
  static int? id = -1;

  Future<void> AutoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('id');
    if (userId == null || userId == -1) {
      islogged = false;
    } else {
      islogged = true;
      id = userId;
    }
  }

  static Future<void> loginUser(int userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', userId);
    islogged = true;
    id = userId;
  }

  Future<void> logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', -1);
    islogged = false;
    id = -1;
  }

  
}
