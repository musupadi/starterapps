import 'package:flutter/material.dart';
import 'package:project_management/LoginIn.dart';

import 'Constant/colors.dart';
import 'Login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
          primaryColor: PrimaryColors(),
          primaryColorDark: PrimaryColorsDark(),
          primarySwatch: Colors.brown,
          fontFamily: 'gotham'
      ),
      debugShowCheckedModeBanner: false,
      home: Login()
    );
  }
}

