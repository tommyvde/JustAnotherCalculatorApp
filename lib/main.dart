import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'IOWidget.dart';

void main() {
  runApp(const JustAnotherCalculatorApp());
}

// public variable for the theme colors
Color themeColor = Colors.blueGrey;
Color themeTextColor = Colors.black54;

class JustAnotherCalculatorApp extends StatelessWidget {
  const JustAnotherCalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Just Another Calculator App',
      theme: ThemeData.dark(),
      home: const HomePage(
        title: 'Just Another Calculator App',
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String _title;

  const HomePage({super.key, required String title}) : _title = title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor,
          foregroundColor: themeTextColor,
          title: Text(_title),
        ),
        body: Container(
            alignment: Alignment.bottomCenter, child: const IOWidget()));
  }
}
