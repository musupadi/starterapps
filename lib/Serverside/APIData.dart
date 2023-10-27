import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project_management/Liblary/Ascendant.dart';
import 'package:project_management/Liblary/SharedPreferance.dart';
import 'package:project_management/Route.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'API.dart';
import 'Server.dart';


LoginData(BuildContext context,String username,String Password) async{
  try{
    final url = Uri.parse(APIBaseURL()+Login());
    final request = http.MultipartRequest('POST', url);
    request.fields['email'] = username;
    request.fields['password'] = Password;
    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    if(jsonDecode(respStr)['code'] == 0){
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('id_user', jsonDecode(respStr)['data'][0]['id_user'].toString());
      await prefs.setString('email', jsonDecode(respStr)['data'][0]['email'].toString());
      await prefs.setString('nama', jsonDecode(respStr)['data'][0]['nama'].toString());
      await prefs.setString('image_picture', jsonDecode(respStr)['data'][0]['image_picture'].toString());
      await prefs.setString('level', jsonDecode(respStr)['data'][0]['level'].toString());
      await prefs.setString('link_gmail', jsonDecode(respStr)['data'][0]['link_gmail'].toString());
      //
      //
      // String? token = prefs.getString('token_user');
      // String? level = prefs.getString("level");
      String? s = prefs.getString("nama");
      // String? id_user = prefs.getString("id_user");
      LoginSuccess(context,s.toString());
    }else{
      Message(jsonDecode(respStr)['Message'], context);
    }
  }on Exception catch (_){
    Message("Terjadi Kesalahan pada $_", context);
  }
}
CreateProject(BuildContext context,String name,String pm,String note,String start_date,String end_date,String target_date) async{
  try{
    final url = Uri.parse(APIBaseURL()+StringCreateProject());
    final request = http.MultipartRequest('POST', url);
    request.fields['name'] = name;
    request.fields['owner'] = await SharedUserId();
    request.fields['pm'] = pm;
    request.fields['status'] = "";
    request.fields['note'] = note;
    request.fields['color'] = "";
    request.fields['start_date'] = start_date;
    request.fields['end_date'] = end_date;
    request.fields['target_date'] = target_date;
    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    if(jsonDecode(respStr)['code'] == 0){
      AwesomeDialog(
          context: context,
          dismissOnTouchOutside: true,
          dismissOnBackKeyPress: false,
          dialogType: DialogType.success,
          animType: AnimType.scale,
          title: "Input Project Berhasil",
          desc: jsonDecode(respStr)['Message'],
          btnOkOnPress: () {
            toDashboard(context);
          },
          headerAnimationLoop: false
      )..show();
    }else{
      Message(jsonDecode(respStr)['Message'], context);
    }
  }on Exception catch (_){
    Message("Terjadi Kesalahan pada $_", context);
  }
}
CreateTask(BuildContext context,String name,String id_project,String staff,String note,String start_date,String end_date,String target_date) async{
  try{
    final url = Uri.parse(APIBaseURL()+StringCreateTask());
    final request = http.MultipartRequest('POST', url);
    request.fields['name'] = name;
    request.fields['id_project'] = id_project;
    request.fields['pm'] = await SharedUserId();
    request.fields['staff'] = staff;
    request.fields['status'] = "";
    request.fields['note'] = note;
    request.fields['color'] = "";
    request.fields['start_date'] = start_date;
    request.fields['end_date'] = end_date;
    request.fields['target_date'] = target_date;
    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    if(jsonDecode(respStr)['code'] == 0){
      AwesomeDialog(
          context: context,
          dismissOnTouchOutside: true,
          dismissOnBackKeyPress: false,
          dialogType: DialogType.success,
          animType: AnimType.scale,
          title: "Input Task Berhasil",
          desc: jsonDecode(respStr)['Message'],
          btnOkOnPress: () {
            toDashboard(context);
          },
          headerAnimationLoop: false
      )..show();
    }else{
      Message(jsonDecode(respStr)['Message'], context);
    }
  }on Exception catch (_){
    Message("Terjadi Kesalahan pada $_", context);
  }
}
CreateRealization(BuildContext context,String id_task,String progress,String note) async{
  try{
    final url = Uri.parse(APIBaseURL()+StringCreateRealization());
    final request = http.MultipartRequest('POST', url);
    request.fields['id_task'] = id_task;
    request.fields['id_staff'] = await SharedUserId();
    request.fields['progress'] = progress;
    request.fields['status'] = "";
    request.fields['note'] = note;
    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    if(jsonDecode(respStr)['code'] == 0){
      Message(jsonDecode(respStr)['Message'], context);
    }else{
      Message(jsonDecode(respStr)['Message'], context);
    }
  }on Exception catch (_){
    Message("Terjadi Kesalahan pada $_", context);
  }
}
Future<List> getProjectNama(String nama) async{
  final response=await http.get(
    Uri.parse(
        APIBaseURL()+
            StringGetNamaProject(nama)
    ),
  ).timeout(Duration(seconds: 10));
  return json.decode(response.body)['data'];
}
Future<List> ReadProject() async{
  final response=await http.get(
    Uri.parse(
        APIBaseURL()+
            StringReadProject(await SharedUserId(),"1")
    ),
  ).timeout(Duration(seconds: 10));
  return json.decode(response.body)['data'];
}
Future<List> WhereReadProject(String id_project) async{
  final response=await http.get(
    Uri.parse(
        APIBaseURL()+
            StringWhereReadProject(await SharedUserId(),id_project,"1")
    ),
  ).timeout(Duration(seconds: 10));
  return json.decode(response.body)['data'];
}
Future<List> WhereReadRealization(String id_task) async{
  final response=await http.get(
    Uri.parse(
        APIBaseURL()+
            StringWhereReadRealization(await SharedUserId(),id_task)
    ),
  ).timeout(Duration(seconds: 10));
  return json.decode(response.body)['data'];
}
Future<List> ReadTask(String id_project) async{
  final response=await http.get(
    Uri.parse(
        APIBaseURL()+
            StringReadTask(await SharedUserId(),id_project)
    ),
  ).timeout(Duration(seconds: 10));
  return json.decode(response.body)['data'];
}

Future<dynamic> ProjectProgress(String id_project) async{
  final response=await http.get(
    Uri.parse(
        APIBaseURL()+
            StringProgressProject(id_project,await SharedUserId(),"1")
    ),
  ).timeout(Duration(seconds: 5));
  String data = json.decode(response.body)['Progress'].toString();
  return data;
}
Future<String> TaskProgress(String id_task) async{
  final response=await http.get(
    Uri.parse(
        APIBaseURL()+
            StringProgressTask(id_task,await SharedUserId())
    ),
  ).timeout(Duration(seconds: 5));
  String data = json.decode(response.body)['Progress'][0]['progress'].toString();
  return data;
}
Future<List> SearchUser(String nama,String level) async{
  final response=await http.get(
    Uri.parse(
        APIBaseURL()+
            StringSearchUser(nama,level)
    ),
  ).timeout(Duration(seconds: 5));
  return json.decode(response.body)['data'];
}