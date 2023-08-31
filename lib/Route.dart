import 'package:flutter/material.dart';
import 'package:project_management/Dashboard.dart';
import 'package:project_management/MyWork/MyRealization.dart';
import 'package:project_management/MyWork/MyTask.dart';
import 'package:project_management/Profile/Costumized.dart';
import 'package:project_management/Profile/Custom.dart';
import 'package:project_management/Profile/Domain.dart';
import 'package:project_management/Profile/InputColorPickerCostumized.dart';
import 'package:project_management/Profile/InputFotoCostumized.dart';
import 'package:project_management/Profile/Preset.dart';
import 'package:project_management/Project/AddProject.dart';
import 'package:project_management/Task/AddTask.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';

void toDashboard(BuildContext context){
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
            return Dashboard();
          }
      )
  );
}
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

void toMyTask(BuildContext context,String id_project) async{
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
            return MyTask(id_project: id_project);
          }
      )
  );
}
void toAddProject(BuildContext context) async{
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
            return AddProject();
          }
      )
  );
}
void toAddTask(BuildContext context,String id_project) async{
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
            return AddTask(id_project: id_project);
          }
      )
  );
}
void toMyRealization(
    BuildContext context,
    String id_project,
    String status,
    String start_date,
    String end_date,
    String target_date,
    String id_task,
    String name,
    String note,
    String pm,
    String pmNama,
    String staff,
    String staffNama,
    String progress
    ) async{
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
            return MyRealization(
              id_project: id_project,
              status: status,
              start_date: start_date,
              end_date: end_date,
              target_date: target_date,
              id_task: id_task,
              name: name,
              note: note,
              pm: pm,
              pmNama: pmNama,
              staff: staff,
              staffNama: staffNama,
              progress: progress
            );
          }
      )
  );
}