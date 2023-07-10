import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  double maxCps = 0.0;

  void loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      maxCps = prefs.getDouble('maxCps') ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    loadPreferences();

    final appbar = AppBar(
      leading: const Icon(
        CupertinoIcons.bolt_fill,
      ),
      title: const Text('Trainee Insper Mileage',
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
    );

    return Scaffold(
      appBar: appbar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Seu recorde:',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            RichText(
              text: TextSpan(
                text: maxCps.toStringAsFixed(2).replaceFirst('.', ','),
                style: TextStyle(
                fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: widget.theme.primaryColor,
                ),
                children: [
                  TextSpan(
                    text: ' CPS',
                    style: TextStyle(
                    fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              )
            )
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/clicker'),
        child: const Icon(Icons.speed_outlined),
      ),
    );
  }
}
