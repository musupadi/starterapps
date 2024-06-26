import 'package:flutter/material.dart';
import 'package:project_management/Serverside/APIData.dart';

import '../Liblary/Ascendant.dart';
import '../Loading.dart';

class UserManagement extends StatefulWidget {


  UserManagement({Key? key}) : super(key: key);

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCustomPreset(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return FutureBuilder(
            future: getReadAllUser(),
            builder: (context, project) {
              if(project.hasData){
                return SafeArea(
                  child: Scaffold(
                    backgroundColor: Color(int.parse("FF"+snapshot.requireData[7]['data'] , radix: 16)),
                    body: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          itemCount: project.requireData.length,
                          itemBuilder: (context, index) {
                            if(project.hasData){

                            }else{
                              return NotFound("User Tidak Ada");
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
