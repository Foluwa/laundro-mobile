import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  // ignore: always_declare_return_types
  setJWT(String jwt) async {
    final prefs = await SharedPreferences.getInstance();
    // print('JWT $jwt');
    await prefs.setString('JWT', jwt);
    print('Jwt Set $jwt');
  }

  //
  Future<String?>? getJwt() async {
    final prefs = await SharedPreferences.getInstance();
    //Return String
    // print(prefs.getString('JWT'));
    // print(prefs.getString('JWT'));
    return prefs.getString('JWT');
  }

  // Remove a pref
  void removePref(String keyName) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(keyName);
  }

  // Clear all shared preferences
  void clearPrefs() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  //
  // skipSlideShow() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('skipSlideShow', true);
  // }
  //
  // shouldSkipSlideShow() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool('skipSlideShow') ?? false;
  // }
}
