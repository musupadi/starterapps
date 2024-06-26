import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_management/Adapter/TaskAdapter.dart';
import 'package:project_management/Constant/colors.dart';
import 'package:project_management/Route.dart';
import 'package:project_management/Serverside/APIData.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Liblary/Ascendant.dart';
import '../Loading.dart';

class MyTask extends StatefulWidget {
  String id_project;
  MyTask(
      {
        Key? key,
        required this.id_project,
      }
    );

  @override
  State<MyTask> createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> {

  String level = "staff";
  String stat = "0";
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
  Widget build(BuildContext context) {
    final _random = new Random();
    return FutureBuilder(
      future: getCustomPreset(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return FutureBuilder(
            future: WhereReadProject(widget.id_project),
            builder: (context, project) {
              if(project.hasData){
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
                            toGanttChartPlanning(context, widget.id_project);
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
                                  project.requireData[0]['name'],
                                  style: TextStyle(
                                      fontSize: 25
                                  ),
                                ),
                                Container(
                                  color: Colors.red,
                                  width: 100,
                                  height: 1,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                          "Owner"
                                      ),
                                    ),
                                    Expanded(
                                        child: Text(
                                            ": "+project.requireData[0]['ownerNama']
                                        )
                                    )
                                  ],
                                ),
                                Text("Progress"),
                                Container(
                                  color: Colors.red,
                                  width: 50,
                                  height: 1,
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  height: 70,
                                  child: FutureBuilder(
                                    future: ProjectProgress(widget.id_project,"0"),
                                    builder: (context, snapshot){
                                      if(snapshot.hasData){
                                        return ProgressBar(context, double.parse(snapshot.requireData), _random.nextInt(StyleCount()));
                                      }else if(snapshot.hasError){
                                        return ProgressBar(context, 0, 1);
                                      }else{
                                        print("Zyarga Debugger Check : "+snapshot.requireData.toString());
                                        return ProgressBar(context, 0, 1);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Visibility(
                          visible: level == "pm" ? true : false,
                          child: InkWell(
                            onTap: () {
                              toAddTask(context,widget.id_project);
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
                                      "Assign Task"
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: level == "pm" ? true : false,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text("Project Selesai ?"),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50)
                                ),
                                margin: EdgeInsets.all(10),
                                child: Row(
                                 children: [
                                   Expanded(
                                     flex: 1,
                                     child: InkWell(
                                       onTap: () {
                                         setState(() {
                                            UpdateStatusProject(context, project.requireData[0]['id_project'],level, "1");
                                         });
                                         // toAddTask(context,widget.id_project);
                                       },
                                       child: AnimatedContainer(
                                         duration: Duration(milliseconds: 500),
                                         decoration: BoxDecoration(
                                             color: project.requireData[0]['status'] == "1" ? Colors.red : Colors.white ,
                                             borderRadius: BorderRadius.circular(50)
                                         ),
                                         child: Padding(
                                           padding: const EdgeInsets.all(10.0),
                                           child: Center(
                                             child: Text(
                                               "Progress",
                                               style: TextStyle(
                                                 color:  project.requireData[0]['status'] == "1" ? Colors.white: Colors.black ,
                                               ),
                                             ),
                                           ),
                                         ),
                                       ),
                                     ),
                                   ),
                                   Expanded(
                                     flex: 1,
                                     child: InkWell(
                                       onTap: () {
                                         setState(() {
                                           UpdateStatusProject(context, project.requireData[0]['id_project'],level, "2");
                                         });
                                         // toAddTask(context,widget.id_project);
                                       },
                                       child: AnimatedContainer(
                                         duration: Duration(milliseconds: 500),
                                         margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                                         decoration: BoxDecoration(
                                             color: project.requireData[0]['status'] == "2" ? Colors.red : Colors.white ,
                                             borderRadius: BorderRadius.circular(50)
                                         ),
                                         child: Padding(
                                           padding: const EdgeInsets.all(10.0),
                                           child: Center(
                                             child: Text(
                                                 "Finish",
                                               style: TextStyle(
                                                 color: project.requireData[0]['status'] == "2" ? Colors.white: Colors.black ,
                                              ),
                                             ),
                                           ),
                                         ),
                                       ),
                                     ),
                                   ),
                                 ],
                                ),
                              ),
                            ],
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                          child: Text(
                              "Task",
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
                          future: ReadTask(widget.id_project),
                          builder: (context, task) {
                            if(task.hasData){
                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: task.requireData.length,
                                itemBuilder: (context, index) {
                                  return TaskAdapter(
                                      name: task.requireData[index]['name'],
                                      id_task: task.requireData[index]['id_task'],
                                      id_project: task.requireData[index]['id_project'],
                                      pm: task.requireData[index]['pm'],
                                      staff: task.requireData[index]['staff'],
                                      status: task.requireData[index]['status'],
                                      note: task.requireData[index]['note'],
                                      start_date: task.requireData[index]['start_date'],
                                      end_date: task.requireData[index]['end_date'],
                                      target_date: task.requireData[index]['target_date'],
                                      pmNama: task.requireData[index]['pmNama'],
                                      staffNama: task.requireData[index]['staffNama']
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
                return Container();
              }
            },
          );
        }else{
          return Loading();
        }
      },
    );
  }
}
