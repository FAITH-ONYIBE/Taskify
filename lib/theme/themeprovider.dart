// import 'package:flutter/material.dart';


// class Themeprovider extends ChangeNotifier {
//   ThemeData _themeData = _lightTheme;

//   ThemeData get themeData => _themeData;

//   static final ThemeData _lightTheme = ThemeData(
//     brightness: Brightness.light,
//     scaffoldBackgroundColor: const Color(0xFFF3F5FF), // soft light background
//     primaryColor: const Color(0xFF0A174E), // navy accent
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Color(0xFF0A174E),
//       foregroundColor: Colors.red,
//     ),
//     textTheme: const TextTheme(
//       bodyLarge: TextStyle(color: Colors.black87),
//       bodyMedium: TextStyle(color: Colors.black54),
//     ),
//     iconTheme: const IconThemeData(color: Colors.black87),
//     floatingActionButtonTheme: const FloatingActionButtonThemeData(
//       backgroundColor: Color(0xFF0A174E),
//     ),
//   );

  
//   static final ThemeData _darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     scaffoldBackgroundColor: const Color(0xFF0A174E), 
//     // primaryColor: Colors.purpleAccent,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Color(0xFF0A174E),
//       foregroundColor: Colors.white,
//     ),
//     textTheme: const TextTheme(
//       bodyLarge: TextStyle(color: Colors.white),
//       bodyMedium: TextStyle(color: Colors.white70),
//     ),
//     iconTheme: const IconThemeData(color: Colors.white),
//     floatingActionButtonTheme: const FloatingActionButtonThemeData(
//       backgroundColor: Colors.blue,
//     ),
//   );

//   void toggleTheme() {
//     if (_themeData == _lightTheme) {
//       _themeData = _darkTheme;
//     } else {
//       _themeData = _lightTheme;
//     }
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';

class Themeprovider extends ChangeNotifier {
  // Default theme is Light
  ThemeData _themeData = _lightTheme;

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    if (_themeData.brightness == Brightness.light) {
      _themeData = _darkTheme;
    } else {
      _themeData = _lightTheme;
    }
    notifyListeners();
  }

  // Light Theme
  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    // primarySwatch: Colors.,
    colorScheme: ColorScheme.light(
      primary:  const Color.fromARGB(255, 2, 60, 107),
      secondary: const Color.fromARGB(255, 2, 60, 107),
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.grey[100],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.black),
  );

  // Dark Theme
  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepPurple,
    colorScheme: ColorScheme.dark(
      primary: Colors.deepPurple,
      secondary: Colors.deepPurpleAccent,
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: Color(0xFF121212),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blueAccent,
      foregroundColor: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  );
}
