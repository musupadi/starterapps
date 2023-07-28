import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:project_management/Route.dart';
import 'package:project_management/Serverside/API.dart';

import '../Constant/colors.dart';
import '../Liblary/Ascendant.dart';
import '../Serverside/Server.dart';
import 'package:http/http.dart' as http;

class InputFotoCostumized extends StatefulWidget {
  String id_design_detail;
  String CategoryName;
  String CategoryDescription;
  InputFotoCostumized({Key? key,
    required this.id_design_detail,
    required this.CategoryName,
    required this.CategoryDescription
  });

  @override
  State<InputFotoCostumized> createState() => _InputFotoCostumizedState();
}

class _InputFotoCostumizedState extends State<InputFotoCostumized> {
  var _selectedPhoto;
  bool isLoading = false;
  Future<void> _uploadData() async {
    final url = Uri.parse(APIBaseURL()+UpdateCustomDesign());
    final request = http.MultipartRequest('POST', url);
    request.fields['id'] = widget.id_design_detail;
    request.files.add(
      await http.MultipartFile.fromPath('data', _selectedPhoto.path),
    );
    request.fields['picture'] = "true";
    request.fields['id_user'] = "1";
    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    print("Zyarga Debugger : "+respStr.toString());
    if(jsonDecode(respStr)['status']==false){
      setState(() {
        isLoading=false;
      });
      Message(jsonDecode(respStr)['Message'].toString(), context);
    }else{
      setState(() {
        isLoading=false;
      });
      AwesomeDialog(
          context: context,
          dismissOnTouchOutside: true,
          dismissOnBackKeyPress: true,
          dialogType: DialogType.noHeader,
          animType: AnimType.topSlide,
          body: Column(
            children: [
              Center(
                child: Lottie.asset(
                  "assets/lottie/thumbup.json",
                  width: 150,
                  height: 150,
                  repeat: false,
                ),
              ),
              Text("Succes Updated Image",
                style: TextStyle(
                    color: Colors.black
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
          btnCancelText: "Kembali ke Custom",
          btnCancelOnPress: () {
            toCustom(context);
          },
          headerAnimationLoop:false
      )..show();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Image"),
        backgroundColor: PrimaryColors(),
      ),
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: SecondaryColors(),
          ),
          ListView(
            shrinkWrap: true,
            children: [
              InkWell(
                onTap: () async {
                  final photo = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );
                  if (photo != null) {
                    setState(() {
                      _selectedPhoto = File(photo.path);
                    });
                  }
                },
                child: Container(
                  width: double.maxFinite,
                  height: 50,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        "Take Image",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              _selectedPhoto != null ?
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        image: DecorationImage(
                            image: FileImage(_selectedPhoto),
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                        _uploadData();
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: 50,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            "Change Image",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ) :
              Container(),

            ],
          ),
          isLoading
              ?Container(
              width: double.maxFinite,
              height: double.maxFinite,
              color: Colors.white.withOpacity(0.7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/lottie/loadingsent.json",
                    width: 300,
                    height: 300,
                  ),
                  Text("Mohon Tunggu Sebentar Sedang Mencoba Register")
                ],
              )
          )
              :Container(),
        ],
      ),
    );
  }
}
