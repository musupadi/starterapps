import 'package:flutter/material.dart';
import 'package:project_management/Liblary/Ascendant.dart';
import 'package:project_management/Loading.dart';
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
    return FutureBuilder(
      future: getCustomPreset(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return MaterialApp(
              title: 'Splash Screen',
              theme: ThemeData(
                  primaryColor: Color(int.parse("FF"+snapshot.requireData[6]['data'] , radix: 16)),
                  primaryColorDark: Color(int.parse("FF"+snapshot.requireData[6]['data'] , radix: 16)),
                  primarySwatch: MaterialColor(int.parse("0xFF"+snapshot.requireData[6]['data']), <int, Color>{
                    50: Color(int.parse("0xFF"+snapshot.requireData[6]['data'])),
                    100: Color(int.parse("0xFF"+snapshot.requireData[6]['data'])),
                    200: Color(int.parse("0xFF"+snapshot.requireData[6]['data'])),
                    300: Color(int.parse("0xFF"+snapshot.requireData[6]['data'])),
                    400: Color(int.parse("0xFF"+snapshot.requireData[6]['data'])),
                    500: Color(int.parse("0xFF"+snapshot.requireData[6]['data'])),
                    600: Color(int.parse("0xFF"+snapshot.requireData[6]['data'])),
                    700: Color(int.parse("0xFF"+snapshot.requireData[6]['data'])),
                    800: Color(int.parse("0xFF"+snapshot.requireData[6]['data'])),
                    900: Color(int.parse("0xFF"+snapshot.requireData[6]['data'])),
                  }),
                  fontFamily: 'gotham'
              ),
              debugShowCheckedModeBanner: false,
              home: Login()
          );
        }else{
          return MaterialApp(
              title: 'Splash Screen',
              theme: ThemeData(
                  primaryColor: PrimaryColors(),
                  primaryColorDark: PrimaryColors(),
                  primarySwatch: Colors.brown,
                  fontFamily: 'gotham'
              ),
              debugShowCheckedModeBanner: false,
              home: Loading()
          );
        }
      },
    );
  }
}

