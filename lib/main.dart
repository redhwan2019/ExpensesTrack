import 'package:excer/pages/expenses/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.pink,
        brightness: Brightness.light,
      ),
      home: LoginPage(),
    );
  }
}
