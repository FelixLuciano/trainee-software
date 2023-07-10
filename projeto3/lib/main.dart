import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'routes/home/home.dart';
import 'routes/clicker/clicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {

    final theme = ThemeData(
      primarySwatch: const MaterialColor(0xFFFF440D, {
        50: Color(0xFFFFE9E2),
        100: Color(0xFFFFC7B6),
        200: Color(0xFFFFA286),
        300: Color(0xFFFF7C56),
        400: Color(0xFFFF6031),
        500: Color(0xFFFF440D),
        600: Color(0xFFFF3E0B),
        700: Color(0xFFFF3509),
        800: Color(0xFFFF2D07),
        900: Color(0xFFFF1F03),
      }),
    );

    return MaterialApp(
      theme: theme,
      title: 'Trainee Insper Mileage',
      routes: {
        '/': (context) => Home(theme: theme),
        '/clicker': (context) => Clicker(theme: theme),
      },
    );
  }
}
