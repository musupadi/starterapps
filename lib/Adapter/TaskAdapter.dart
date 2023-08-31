import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_management/Route.dart';
import 'package:project_management/Serverside/APIData.dart';
import 'package:http/http.dart' as http;
import '../Constant/colors.dart';
import '../Liblary/Ascendant.dart';
import '../Liblary/SharedPreferance.dart';
import '../Serverside/API.dart';
import '../Serverside/Server.dart';

class TaskAdapter extends StatefulWidget {
  String name;
  String id_task;
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
  TaskAdapter({
    Key? key,
    required this.name,
    required this.id_task,
    required this.id_project,
    required this.pm,
    required this.staff,
    required this.status,
    required this.note,
    required this.start_date,
    required this.end_date,
    required this.target_date,
    required this.pmNama,
    required this.staffNama
  });

  @override
  State<TaskAdapter> createState() => _TaskAdapterState();
}

class _TaskAdapterState extends State<TaskAdapter> {
  final _random = new Random();
  String progress = "0";
  JansAnjng(String id_task) async{
    final response=await http.get(
      Uri.parse(
          APIBaseURL()+
              StringProgressTask(id_task,await SharedUserId())
      ),
    ).timeout(Duration(seconds: 5));
    setState(() {
      print("Progress check"+json.decode(response.body)['Progress'][0]['progress'].toString());
      progress = json.decode(response.body)['Progress'][0]['progress'].toString();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    JansAnjng(widget.id_task);
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        toMyRealization(
            context,
            widget.id_project,
            widget.status,
            widget.start_date,
            widget.end_date,
            widget.target_date,
            widget.id_task,
            widget.name,
            widget.note,
            widget.pm,
            widget.pmNama,
            widget.staff,
            widget.staffNama,
            progress
        );
        // Message(widget.id_project, context);
        // toMyTask(context, widget.id_project);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10,bottom: 5),
                  height: 1,
                  width: double.maxFinite,
                  color: Colors.red,
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text("Project Manager"),
                    ),
                    Expanded(
                      child: Text(
                          ": "+widget.pmNama
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text("Staff"),
                    ),
                    Expanded(
                      child: Text(
                          ": "+widget.staffNama
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text("Start Date"),
                    ),
                    Expanded(
                      child: Text(
                          ": "+widget.start_date
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text("End Date"),
                    ),
                    Expanded(
                      child: Text(
                          ": "+widget.end_date
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text("Target Date"),
                    ),
                    Expanded(
                      child: Text(
                          ": "+widget.target_date
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Text(
                  "Progress Task",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
                FutureBuilder(
                  future: TaskProgress(widget.id_task),
                  builder: (context, progress){
                    if(progress.hasData){
                      return ProgressBar(context, double.parse(progress.requireData), _random.nextInt(StyleCount()));
                    }else if(progress.hasError){
                      return ProgressBar(context, 0, 1);
                    }else{
                      print("Zyarga Debugger Check : "+progress.requireData.toString());
                      return ProgressBar(context, 0, 1);
                    }
                  },
                )
              ],
            )
        ),
      ),
    );
  }
}
