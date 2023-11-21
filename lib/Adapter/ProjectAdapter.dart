import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_management/Liblary/Ascendant.dart';
import 'package:project_management/Route.dart';
import 'package:project_management/Serverside/APIData.dart';

import '../Constant/colors.dart';

class ProjectAdapter extends StatefulWidget {
  String id_project;
  String name;
  String pmId;
  String pmName;
  String ownerId;
  String ownerName;
  String status;
  String note;
  String color;
  String start_date;
  String end_date;
  String target_date;
  ProjectAdapter({
    Key? key,
    required this.id_project,
    required this.name,
    required this.pmId,
    required this.pmName,
    required this.ownerId,
    required this.ownerName,
    required this.status,
    required this.note,
    required this.color,
    required this.start_date,
    required this.end_date,
    required this.target_date,
  });

  @override
  State<ProjectAdapter> createState() => _ProjectAdapterState();
}

class _ProjectAdapterState extends State<ProjectAdapter> {
  final _random = new Random();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Message(widget.id_project, context);
        toMyTask(context, widget.id_project);
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
                    child: Text("Owner"),
                  ),
                  Expanded(
                    child: Text(
                        ": "+widget.ownerName
                    ),
                  )
                ],
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
                      ": "+widget.pmName
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
                  "Progress Project",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
              ),
              FutureBuilder(
                future: ProjectProgress(widget.id_project,"0"),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    // return Text(snapshot.requireData);
                    return ProgressBar(context, double.parse(snapshot.requireData=="Project Tidak Terbaca" ? 0 : snapshot.requireData), _random.nextInt(StyleCount()));
                  }else if(snapshot.hasError){
                    return ProgressBar(context, 0, 1);
                  }else{
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
