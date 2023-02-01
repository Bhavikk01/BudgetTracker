import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeServices extends ChangeNotifier {
  final SharedPreferences sharedPreferences;
  ThemeServices(this.sharedPreferences);

  static const darkThemeKey = "dark_theme";
  bool _darkTheme = true;

  bool get darkTheme {
    return sharedPreferences.getBool(darkThemeKey) ?? _darkTheme;
  }

  set darkTheme(bool value) {
    _darkTheme = value;
    sharedPreferences.setBool(darkThemeKey, value);
    notifyListeners();
  }
}