import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './gauge.dart';


class Clicker extends StatefulWidget {
  const Clicker({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  State<Clicker> createState() => ClickerState();
}

class ClickerState extends State<Clicker> {
  DateTime? timeStart;
  Timer? resetTimer;
  int count = 0;
  double cps = 0.0;
  double maxCps = 0.0;

  void click(BuildContext context) {
    DateTime nowClick = DateTime.now();

    if (timeStart != null) {
      int timeDelta = nowClick.millisecondsSinceEpoch - timeStart!.millisecondsSinceEpoch;
      double frequency = (++count * 1000) / timeDelta;

      if (timeDelta > 500) {
        maxCps = maxCps > frequency ? maxCps : frequency;
      }

      setState(() => cps = frequency);
    }
    else {
      timeStart = nowClick;
    }

    resetTimer?.cancel();

    resetTimer = Timer(const Duration(seconds: 1), () => reset(context));
  }

  void reset(BuildContext context) async {    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var prefsMaxCps = prefs.getDouble('maxCps') ?? 0.0;

    if (maxCps > prefsMaxCps) {
      var snackBar = SnackBar(
        content: Text("🎉 Parabéns! ${maxCps.toStringAsFixed(2)} é seu novo recorde. 🎉"),
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      await prefs.setDouble('maxCps', maxCps);
    }

    count = 0;
    timeStart = null;

    setState(() => cps = 0);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: ButtonTheme(
        child: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(CupertinoIcons.arrow_left),
        ),
      ),
      title: Text('Clicker',
        style: TextStyle(
          color: widget.theme.primaryColor
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Gauge(cps: cps, theme: widget.theme),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.ads_click),
        
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        label: const Text('CLIQUE'),
        onPressed: () => click(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
