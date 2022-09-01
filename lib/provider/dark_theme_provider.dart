import 'package:flutter/widgets.dart';
import 'package:shop_app/models/dark_theme_prefrences.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePrefrences darkThemePrefrences = new DarkThemePrefrences();
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePrefrences.setDarkTheme(value);
    notifyListeners();
  }
}
