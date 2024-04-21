import 'package:flutter/material.dart';
import 'package:tourism_web_app/utility/utility.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeData _currentTheme;

  // Light Theme
  final ThemeData _lightTheme = ThemeData(
    primarySwatch: createMaterialColor(Color.fromRGBO(136, 112, 200, 1)),

    scaffoldBackgroundColor: Color(0xFFF9FAFA),

    primaryColor: Colors.white,
    // primaryColor: const Color(0XF,

    brightness: Brightness.light,
    inputDecorationTheme:
        const InputDecorationTheme(fillColor: Colors.blueGrey, filled: true),

    iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.black26)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        // backgroundColor: Color(0xff7770c8),
        backgroundColor: Color(0xff6d71f9),
        textStyle: TextStyle(
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.all(8),
        // side: BorderSide(
        //     width: 2.0, // The thickness of the border
        //     color: Color(0xFF8870c8) // The color of the border
        //     ),
      ),
    ),
    // Other theme properties (e.g., text styles) can be customized here
  );

  // Dark Theme
  final ThemeData _darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    // primaryColor: Color(0xFF8870C8),
    brightness: Brightness.dark,

    iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.black26)),

    inputDecorationTheme:
        InputDecorationTheme(fillColor: Colors.grey[800], filled: true),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff7770c8).withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.all(8),
        side: BorderSide(
            width: 2.0, // The thickness of the border
            color: Color(0xFF8870c8) // The color of the border
            ),
      ),
    ),

    // Customize other dark theme properties (e.g., background color, text styles)
    // Example: backgroundColor, textTheme, buttonTheme, etc.
  );

  ThemeProvider() {
    _currentTheme = _lightTheme;
  }

  ThemeData get currentTheme => _currentTheme;

  // Method to toggle between light and dark themes
  void toggleTheme(bool isDark) {
    // _currentTheme = _currentTheme == _lightTheme ? _darkTheme : _lightTheme;
    isDark ? _currentTheme = _darkTheme : _currentTheme = _lightTheme;
    notifyListeners();
  }

  bool isDark() {
    if (_currentTheme == _lightTheme) return false;
    return true;
  }
}
