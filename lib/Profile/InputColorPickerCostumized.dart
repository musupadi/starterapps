import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:project_management/Route.dart';
import 'package:project_management/Serverside/API.dart';

import '../Constant/colors.dart';
import '../Liblary/Ascendant.dart';
import '../Serverside/Server.dart';
import 'package:http/http.dart' as http;

class InputColorPickerCostumized extends StatefulWidget {
  String id_design_detail;
  String CategoryName;
  String CategoryDescription;

  InputColorPickerCostumized({Key? key,
    required this.id_design_detail,
    required this.CategoryName,
    required this.CategoryDescription
  });

  @override
  State<InputColorPickerCostumized> createState() => _InputColorPickerCostumizedState();
}

class _InputColorPickerCostumizedState extends State<InputColorPickerCostumized> {
  bool isLoading = false;
  Color currentColor = Color(00000000);
  List<Color> currentColors = [Color(00000000),Color(00000000)];
  List<Color> colorHistory = [];
  void changeColor(Color color) => setState(() => currentColor = color);
  void changeColors(List<Color> colors) => setState(() => currentColors = colors);
  Future<void> _uploadData() async {
    final url = Uri.parse(APIBaseURL()+UpdateCustomDesign());
    final request = http.MultipartRequest('POST', url);
    request.fields['id'] = widget.id_design_detail;
    // request.files.add(
    //   await http.MultipartFile.fromPath('data', _selectedPhoto.path),
    // );
    request.fields['data'] = currentColors.toString();
    request.fields['picture'] = "false";
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: Container(
                    child: ColorPicker(
                      pickerColor: currentColor,
                      onColorChanged: changeColor,
                      colorHistory: colorHistory,
                      onHistoryChanged: (List<Color> colors) => colorHistory = colors,
                    ),
                  ),
                ),
                Column(
                  children: [
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
                              "Change Color",
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )

              ],
            ),
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
