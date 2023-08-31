import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Color PrimaryColors(){
    return Color.fromRGBO(128,90,70,100);
}
Color PrimaryColorsDark(){
  return Color.fromRGBO(250,240,70,100);
}
Color SecondaryColors(){
  return Color.fromRGBO(250,240,190,100);
}
Color SecondaryColors2(){
  return Color.fromRGBO(250,240,190,100);
}
Color StyleColors(int idStyle){
  if(idStyle==1){
    return Colors.red;
  }else if(idStyle==2){
    return Colors.green;
  }else if(idStyle==3){
    return Colors.blue;
  }else{
    return Colors.black;
  }
}
int StyleCount(){
  return 4;
}
MaterialColor mcgpalette0 = MaterialColor(_mcgpalette0PrimaryValue, <int, Color>{
  500: Color(_mcgpalette0PrimaryValue),
});
int _mcgpalette0PrimaryValue = 0xFF3F51B5;