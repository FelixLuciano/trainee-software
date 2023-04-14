// Import de pacote de widgets Material
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Define a função principal
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const title = 'Trainee Insper Mileage';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
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

    AppBar appbar = AppBar(
      leading: const Icon(
        CupertinoIcons.person_circle_fill,
      ),
      title: const Text(
        MyApp.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );

    const body = Center(
      child: Text(
        'Projeto #3',
        style: TextStyle(fontSize: 24),
      ),
    );

    return MaterialApp(
      theme: theme,
      title: MyApp.title,
      home: Scaffold(
        appBar: appbar,
        body: body,
      ),
    );
  }
}
