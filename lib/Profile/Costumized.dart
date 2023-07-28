import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_management/Liblary/Ascendant.dart';
import 'package:project_management/Route.dart';

import '../Constant/Size.dart';
import '../Constant/colors.dart';
import '../Serverside/API.dart';
import '../Serverside/Server.dart';
import 'package:http/http.dart' as http;
class Costumized extends StatefulWidget {
  String id_preset;
  Costumized({Key? key,
    required this.id_preset,
  });

  @override
  State<Costumized> createState() => _CostumizedState();
}

class _CostumizedState extends State<Costumized> {



  Future<void> updateData(String Data,String id_category) async {
    final url = Uri.parse(APIBaseURL()+UpdateCustomDesign());
    final request = http.MultipartRequest('POST', url);
    request.fields['id'] = id_category;
    request.fields['data'] = Data;
    request.fields['picture'] = "false";
    request.fields['id_user'] = id_category;
    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    print("Zyarga Debugger : "+respStr.toString());
    if(jsonDecode(respStr)['status']==false){
      Message(jsonDecode(respStr)['Message'].toString(), context);
    }else{
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
              Text("Succes Updated Size",
                style: TextStyle(
                    color: Colors.black
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
          btnCancelText: "Back",
          btnCancelOnPress: () {
            Navigator.pop(context);
          },
          headerAnimationLoop:false
      )..show();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Costumized Preset"),
        backgroundColor: PrimaryColors(),
      ),
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: SecondaryColors(),
          ),
          FutureBuilder(
            future: getListCategory(widget.id_preset),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.requireData.length,
                    itemBuilder: (context,i){
                      TextEditingController controllerSize = new TextEditingController();
                      return InkWell(
                        onTap: () {
                          if(snapshot.requireData[i]['image'] == "true"){
                            toInputCostumizedFoto(
                                context,
                                snapshot.requireData[i]['id_design_detail'],
                                snapshot.requireData[i]['name'],
                                snapshot.requireData[i]['description']
                            );
                          }else if(snapshot.requireData[i]['text'] == "true"){
                            toInputCostumizedColor(
                                context,
                                snapshot.requireData[i]['id_design_detail'],
                                snapshot.requireData[i]['name'],
                                snapshot.requireData[i]['description']
                            );
                          }else if(snapshot.requireData[i]['number'] == "true"){
                            AwesomeDialog(
                              context: context,
                              dismissOnTouchOutside: true,
                              dismissOnBackKeyPress: true,
                              dialogType: DialogType.noHeader,
                              animType: AnimType.topSlide,
                              body: Column(
                                children: [
                                  Text("Change Size Data"),
                                  Container(
                                      child: TextField(
                                        controller: controllerSize,
                                        decoration: InputDecoration(
                                            hintText: 'Size Data',
                                            labelText: 'Size',
                                            border: OutlineInputBorder(),
                                        ),
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
                                      )
                                  ),
                                  InkWell(
                                    onTap: () {
                                      updateData(
                                          controllerSize.text,snapshot.requireData[i]['id_design_detail'],
                                      );
                                    },
                                    child: Container(
                                      width: 150,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: PrimaryColors(),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "Change Size",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: FontSizeMedium(),
                                            fontWeight: FontWeight.bold
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: 150,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "Close",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: FontSizeMedium(),
                                              fontWeight: FontWeight.bold
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            )..show();
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              snapshot.requireData[i]['name'],
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: FontSizeMedium(),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }
                );
              }else{
                return new Center(child: CircularProgressIndicator());
              }


            },
          )
        ],
      ),
    );
  }
}
