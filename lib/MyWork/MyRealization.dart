import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:project_management/Adapter/RealizationAdapter.dart';
import 'package:project_management/Serverside/API.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constant/Size.dart';
import '../Constant/colors.dart';
import '../Liblary/Ascendant.dart';
import '../Loading.dart';
import '../Serverside/APIData.dart';

class MyRealization extends StatefulWidget {
  String id_task;
  String name;
  String id_project;
  String pm;
  String staff;
  String status;
  String note;
  String start_date;
  String end_date;
  String target_date;
  String pmNama;
  String staffNama;
  String progress;
  MyRealization({
    Key? key,
    required this.id_task,
    required this.name,
    required this.id_project,
    required this.pm,
    required this.staff,
    required this.status,
    required this.note,
    required this.start_date,
    required this.end_date,
    required this.target_date,
    required this.pmNama,
    required this.staffNama,
    required this.progress
  });

  @override
  State<MyRealization> createState() => _MyRealizationState();
}

class _MyRealizationState extends State<MyRealization> {
  TextEditingController controllerProgress = new TextEditingController();
  TextEditingController controllerNote = new TextEditingController();
  String level = "staff";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedImageLevel();
  }
  SharedImageLevel() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      level = pref.getString("level")!;
    });
  }
  @override
  Widget build(BuildContext context) {
    final _random = new Random();
    return FutureBuilder(
      future: getCustomPreset(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return SafeArea(
            child: Scaffold(
              backgroundColor: Color(int.parse("FF"+snapshot.requireData[7]['data'] , radix: 16)),
              body: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                                fontSize: 25
                            ),
                              // project.requireData[0]['name']
                          ),
                          Container(
                            color: Colors.red,
                            width: 100,
                            height: 1,
                          ),

                          Container(
                            color: Colors.red,
                            width: 50,
                            height: 1,
                          ),
                          //Status
                          widget.status == "" ? Container() : Column(
                            children: [
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Container(
                                    width: 150,
                                    child: Text(
                                        "Status"
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        ": "+widget.status
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          //Note
                          widget.note == "" ? Container() : Column(
                            children: [
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Container(
                                    width: 150,
                                    child: Text(
                                        "Note"
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        ": "+widget.note
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          //Project Manager
                          SizedBox(
                            height: 5,),
                          Row(
                            children: [
                              Container(
                                width: 150,
                                child: Text(
                                    "Project Manager"
                                ),
                              ),
                              Expanded(
                                child: Text(
                                    ": "+widget.pmNama
                                ),
                              )
                            ],
                          ),
                          //Start Date
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Container(
                                width: 150,
                                child: Text(
                                    "Start Date"
                                ),
                              ),
                              Expanded(
                                child: Text(
                                    ": "+DateBuilder(widget.start_date)
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Container(
                                width: 150,
                                child: Text(
                                    "End Date"
                                ),
                              ),
                              Expanded(
                                child: Text(
                                    ": "+DateBuilder(widget.end_date)
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Container(
                                width: 150,
                                child: Text(
                                    "Target Date"
                                ),
                              ),
                              Expanded(
                                child: Text(
                                    ": "+DateBuilder(widget.target_date)
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5,),
                          Text("Progress"),
                          SizedBox(height: 5,),
                          ProgressBar(context,double.parse(widget.progress),_random.nextInt(StyleCount())),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: level == "staff" ? true : false,
                    child: InkWell(
                      onTap: () {
                        AwesomeDialog(
                            autoDismiss: true,
                            context: context,
                            dismissOnTouchOutside: true,
                            dismissOnBackKeyPress: false,
                            dialogType: DialogType.question,
                            animType: AnimType.scale,
                            body: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  //Progress
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: Text("Progress",
                                          style: TextStyle(
                                              fontSize: FontSizeMedium(),
                                              fontWeight: FontWeight.bold
                                          )
                                      )
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5,right: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Container(
                                      height: 50,
                                      margin: EdgeInsets.only(left: 10,right: 10),
                                      child: TextField(
                                        controller: controllerProgress,
                                        decoration: InputDecoration(
                                          hintText: 'Progress',
                                          border: InputBorder.none,
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ),
                                  //Note
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: Text("Note",
                                          style: TextStyle(
                                              fontSize: FontSizeMedium(),
                                              fontWeight: FontWeight.bold
                                          )
                                      )
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5,right: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Container(
                                      height: 50,
                                      margin: EdgeInsets.only(left: 10,right: 10),
                                      child: TextField(
                                        controller: controllerNote,
                                        decoration: InputDecoration(
                                          hintText: 'Note',
                                          border: InputBorder.none,
                                        ),
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            btnOkText: "Submit",
                            btnOkOnPress: () {
                              setState(() {
                                CreateRealization(context, widget.id_task, controllerProgress.text,controllerNote.text);
                              });
                            },
                            btnCancelText: "Cancel",
                            btnCancelOnPress: () {

                            },
                            headerAnimationLoop: false
                        )..show();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                                "Update Progress"
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                    child: Text(
                      "Realization",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10,bottom: 10,right: 10),
                    height: 1,
                    width: double.maxFinite,
                    color: Colors.red,
                  ),
                  FutureBuilder(
                    future: WhereReadRealization(widget.id_task),
                    builder: (context, task) {
                      if(task.hasData){
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: task.requireData.length,
                          itemBuilder: (context, index) {
                            return RealizationAdapter(
                                id_task: task.requireData[index]['id_task'],
                                note: task.requireData[index]['note'],
                                status: task.requireData[index]['status'],
                                id_project: task.requireData[index]['id_project'],
                                updated_at: task.requireData[index]['updated_at'],
                                id_realization: task.requireData[index]['id_realization'],
                                progress: task.requireData[index]['progress'],
                            );
                          },
                        );
                      }else{
                        return Loading();
                      }
                    },
                  )
                ],
              ),
            ),
          );
        }else{
          return Loading();
        }
      },
    );
  }
}
