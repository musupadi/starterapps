import 'package:flutter/material.dart';
import 'package:project_management/Profile/Costumized.dart';
import 'package:project_management/Profile/Custom.dart';
import 'package:project_management/Profile/Domain.dart';
import 'package:project_management/Profile/InputColorPickerCostumized.dart';
import 'package:project_management/Profile/InputFotoCostumized.dart';
import 'package:project_management/Profile/Preset.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';

void toCustom(BuildContext context){
  Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation,
              Widget child) {
            animation = CurvedAnimation(
                parent: animation,
                curve: Curves.elasticInOut
            );
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerRight,
            );
          },
          pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation
              )
          {
            return Custom();
          }
      )
  );
}
void toDomain(BuildContext context){
  Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation,
              Widget child) {
            animation = CurvedAnimation(
                parent: animation,
                curve: Curves.elasticInOut
            );
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerRight,
            );
          },
          pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation
              )
          {
            return Domain();
          }
      )
  );
}
void toPreset(BuildContext context,String id_design){
  Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation,
              Widget child) {
            animation = CurvedAnimation(
                parent: animation,
                curve: Curves.elasticInOut
            );
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerRight,
            );
          },
          pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation
              )
          {
            return Preset(id_design: id_design);
          }
      )
  );
}
void toCostumized(BuildContext context,String id_preset){
  Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation,
              Widget child) {
            animation = CurvedAnimation(
                parent: animation,
                curve: Curves.elasticInOut
            );
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerRight,
            );
          },
          pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation
              )
          {
            return Costumized(id_preset: id_preset);
          }
      )
  );
}
void toInputCostumizedFoto(BuildContext context,String id_design_detail,String CategoryName,String CategoryDescription){
  Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation,
              Widget child) {
            animation = CurvedAnimation(
                parent: animation,
                curve: Curves.elasticInOut
            );
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerRight,
            );
          },
          pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation
              )
          {
            return InputFotoCostumized(id_design_detail: id_design_detail,CategoryDescription: CategoryDescription,CategoryName: CategoryName,);
          }
      )
  );
}
void toInputCostumizedColor(BuildContext context,String id_design_detail,String CategoryName,String CategoryDescription){
  Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation,
              Widget child) {
            animation = CurvedAnimation(
                parent: animation,
                curve: Curves.elasticInOut
            );
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerRight,
            );
          },
          pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation
              )
          {
            return InputColorPickerCostumized(id_design_detail: id_design_detail,CategoryDescription: CategoryDescription,CategoryName: CategoryName,);
          }
      )
  );
}
void Logout(BuildContext context) async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  // FailedMessage("Contoh ", name.toString(), context);

  await pref.clear();

  Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation,
              Widget child) {
            animation = CurvedAnimation(
                parent: animation,
                curve: Curves.elasticInOut
            );
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.center,
            );
          },
          pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation
              )
          {
            return Login();
          }
      )
  );
}