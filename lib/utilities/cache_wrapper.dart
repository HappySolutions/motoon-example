import 'package:motoon_api_example/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheWrapper {
  Future<bool> setUserData(String userData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.USER_DATA_KEY, userData);
      return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  Future<String?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.USER_DATA_KEY);
  }
}
