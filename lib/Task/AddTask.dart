import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Constant/Size.dart';
import '../Constant/colors.dart';
import '../Liblary/Ascendant.dart';
import '../LoadingAwaitData.dart';
import '../Serverside/APIData.dart';

class AddTask extends StatefulWidget {
  String id_project;
  AddTask({
    Key? key,
    required this.id_project
  });

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController TaskName = new TextEditingController();
  TextEditingController StaffID = new TextEditingController();
  TextEditingController Staff = new TextEditingController();


  TextEditingController StartDate = new TextEditingController();
  TextEditingController EndDate = new TextEditingController();
  TextEditingController TargetDate = new TextEditingController();
  TextEditingController Note = new TextEditingController();
  String BackStart = "";
  String BackEnd = "";
  String BackTarget = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asign Task"),
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
              //Project Name
              SizedBox(
                height: 5,
              ),
              Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text("Task Name",
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: TextField(
                    controller: TaskName,
                    decoration: InputDecoration(
                      hintText: 'Task Name',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {

                      });
                    },
                    keyboardType: TextInputType.name,
                  ),
                ),
              ),
              FutureBuilder(
                future: SearchProjectName(TaskName.text),
                builder: (context, pm) {
                  if(pm.hasData){
                    return ListView.builder(
                      itemCount: pm.requireData.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              TaskName.text = pm.requireData[index]['name'];
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: TaskName.text == pm.requireData[index]['name'] ? Colors.red : Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Text(
                                    pm.requireData[index]['name'],
                                    style: TextStyle(
                                        color: TaskName.text == pm.requireData[index]['name'] ? Colors.white : Colors.black,
                                        fontSize: FontSizeLarge()
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                        // bool pilih=false;
                        // return UserAdapter(IDUser: PMID, id_user: pm.requireData[index]['id_user'], nama: pm.requireData[index]['nama'], level: pm.requireData[index]['level']);
                      },
                    );
                  }else{
                    return LoadingAwaitData();
                  }
                },
              ),
              //PM
              SizedBox(
                height: 5,
              ),
              Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text("Assign Project Staff",
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: TextField(
                    controller: Staff,
                    decoration: InputDecoration(
                        hintText: 'Search Staff Name',
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search)
                    ),
                    onChanged: (value) {
                      setState(() {

                      });
                    },
                    keyboardType: TextInputType.name,
                  ),
                ),
              ),
              FutureBuilder(
                future: SearchUser(Staff.text,"staff"),
                builder: (context, pm) {
                  if(pm.hasData){
                    return ListView.builder(
                      itemCount: pm.requireData.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              if(StaffID.text == pm.requireData[index]['id_user']){
                                StaffID.text = "0";
                              }else{
                                StaffID.text = pm.requireData[index]['id_user'];
                              }
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: StaffID.text == pm.requireData[index]['id_user'] ? Colors.red : Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Text(
                                    pm.requireData[index]['nama'],
                                    style: TextStyle(
                                        color: StaffID.text == pm.requireData[index]['id_user'] ? Colors.white : Colors.black,
                                        fontSize: FontSizeLarge()
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    pm.requireData[index]['level'] == "pm" ? "Project Manager" : pm.requireData[index]['level'],
                                    style: TextStyle(
                                        color: StaffID.text == pm.requireData[index]['id_user'] ? Colors.white : Colors.black,
                                        fontSize: FontSizeSmall()
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                        // bool pilih=false;
                        // return UserAdapter(IDUser: PMID, id_user: pm.requireData[index]['id_user'], nama: pm.requireData[index]['nama'], level: pm.requireData[index]['level']);
                      },
                    );
                  }else{
                    return LoadingAwaitData();
                  }
                },
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: TextField(
                    controller: Note,
                    decoration: InputDecoration(
                      hintText: 'Note',
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
              ),
              //StartDate
              SizedBox(
                height: 5,
              ),
              Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text("Start Date",
                      style: TextStyle(
                          fontSize: FontSizeMedium(),
                          fontWeight: FontWeight.bold
                      )
                  )
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () async {
                  BackStart = await selectDate(context);
                  setState(() {
                    StartDate.text = DateBuilder(BackStart);
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 5,right: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: TextField(
                      enabled: false,
                      controller: StartDate,
                      decoration: InputDecoration(
                          hintText: 'Start Date',
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.calendar_month)
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                ),
              ),
              //End Date
              SizedBox(
                height: 5,
              ),
              Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text("End Date",
                      style: TextStyle(
                          fontSize: FontSizeMedium(),
                          fontWeight: FontWeight.bold
                      )
                  )
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () async {
                  BackEnd = await selectDate(context);
                  setState(() {
                    EndDate.text = DateBuilder(BackEnd);
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 5,right: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: TextField(
                      enabled: false,
                      controller: EndDate,
                      decoration: InputDecoration(
                          hintText: 'End Date',
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.calendar_month)
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                ),
              ),

              //Target Date
              SizedBox(
                height: 5,
              ),
              Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text("Target Date",
                      style: TextStyle(
                          fontSize: FontSizeMedium(),
                          fontWeight: FontWeight.bold
                      )
                  )
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () async {
                  BackTarget = await selectDate(context);
                  setState(() {
                    TargetDate.text = DateBuilder(BackTarget);
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 5,right: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: TextField(
                      enabled: false,
                      controller: TargetDate,
                      decoration: InputDecoration(
                          hintText: 'Target Date',
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.calendar_month)
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  CreateTask(context, TaskName.text, widget.id_project,StaffID.text,Note.text,BackStart,BackEnd,BackTarget);
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
                        "Assign Task",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
