import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_management/Adapter/ProjectAdapter.dart';
import 'package:project_management/Liblary/SharedPreferance.dart';
import 'package:project_management/Route.dart';
import 'package:project_management/Serverside/APIData.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Liblary/Ascendant.dart';
import '../Loading.dart';

class MyWork extends StatefulWidget {
  MyWork({Key? key}) : super(key: key);

  @override
  State<MyWork> createState() => _MyWorkState();
}

class _MyWorkState extends State<MyWork> {
  String level = "owner";

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
                  InkWell(
                    onTap: () {

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
                              "Gantt Chart"
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: level == "owner" ? true :false,
                    child: InkWell(
                      onTap: () {
                        toAddProject(context);
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
                              "Assign Project"
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                      future: ReadProject("0"),
                      builder: (context, snapshots) {
                        if(snapshots.hasData){
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshots.requireData.length,
                              itemBuilder: (context, index) {
                                return ProjectAdapter(
                                  id_project: snapshots.requireData[index]['id_project'],
                                  name: snapshots.requireData[index]['name'],
                                  pmId: snapshots.requireData[index]['pmId'],
                                  pmName: snapshots.requireData[index]['pmName'],
                                  ownerId: snapshots.requireData[index]['ownerId'],
                                  ownerName: snapshots.requireData[index]['ownerNama'],
                                  status: snapshots.requireData[index]['status'],
                                  note: snapshots.requireData[index]['note'],
                                  color: snapshots.requireData[index]['color'],
                                  start_date: snapshots.requireData[index]['start_date'],
                                  end_date: snapshots.requireData[index]['end_date'],
                                  target_date: snapshots.requireData[index]['target_date'],
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
