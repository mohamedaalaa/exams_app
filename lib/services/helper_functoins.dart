import 'package:nb_utils/nb_utils.dart';

class HelperFunctions {
  static String userLoggedinKey = "USERLOGGEDINKEY";

  saveUserLoggedInDetails(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(userLoggedinKey, isLoggedIn);
  }

  Future<bool?> getUserLoggedInDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(userLoggedinKey);
  }
}
