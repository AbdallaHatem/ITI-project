import 'package:flutter/material.dart';
import 'package:shopping_app/login/register_page.dart';
import 'package:shopping_app/screens/HomeScreen.dart';
import 'package:shopping_app/login/shared_pref.dart';

void main() {
  runApp( MyApp());
}
class  MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: sharedPref.islogged?HomeScreen():RegisterPage(),
    );
  }
} 