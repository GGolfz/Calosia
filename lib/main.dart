import 'package:flutter/material.dart';
import './screen/detailScreen.dart';
import './screen/mainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calosia',
      theme: ThemeData(
          primaryColor: Color(0xFFFFF9F6),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color(0xFFFF7F51),
            focusColor: Color(0xFFFF7F51),
            splashColor: Color(0xFFFF7F51),
            hoverColor: Color(0xFFFF7F51),
            elevation: 0,
            focusElevation: 0,
            hoverElevation: 0,
            highlightElevation: 0,
          )),
      home: MainScreen(),
      routes: {
        '/food': (ctx) => DetailScreen(),
      },
    );
  }
}

