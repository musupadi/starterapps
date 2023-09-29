import 'package:flutter/material.dart ';

import '../Liblary/Ascendant.dart';
import '../Loading.dart';
import '../Serverside/APIData.dart';

class UserManagement extends StatefulWidget {
  const UserManagement({Key? key}) : super(key: key);

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
          return Scaffold(
            backgroundColor: Color(int.parse("FF"+snapshot.requireData[7]['data'] , radix: 16)),
            appBar: AppBar(
              backgroundColor: Color(int.parse("FF"+snapshot.requireData[7]['data'] , radix: 16)),
              title: Text("User Management"),
            ),
            body: Text("Test")
          );
        }else{
          return Loading();
        }
      },
    );
  }
}
