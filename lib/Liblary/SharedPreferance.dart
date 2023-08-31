import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';



//Future
Future<String> SharedUserId() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("id_user")!;
}
Future<String> SharedUserEmail() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("email")!;
}
Future<String> SharedUserNama() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("nama")!;
}
Future<String> SharedImagePciture() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("image_picture")!;
}
Future<String> SharedImageLevel() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("level")!;
}
Future<String> SharedGmail() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("link_gmail")!;
}