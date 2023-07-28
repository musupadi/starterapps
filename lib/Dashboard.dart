import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_management/Constant/colors.dart';
import 'package:project_management/Loading.dart';
import 'package:project_management/Profile/Profile.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'Liblary/Ascendant.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  String token="";
  String name="";
  String level="";

  void _navigationBottomBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Remove this method to stop OneSignal Debugging
  }

  final List<Widget>tabs = [
    Container(),
    Container(),
    Profile(),
  ];


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return LogoutMessage("Logout", "Are You Sure want to Logout ?", context);
      },
      child: FutureBuilder(
        future: getCustomPreset(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return DefaultTabController(
              length: tabs.length,
              child: Scaffold(
                  body: Container(
                      color: SecondaryColors(),
                      child: tabs[_currentIndex]),
                  bottomNavigationBar: ConvexAppBar.badge(
                    const <int,dynamic>{4:'99+'},
                    style: TabStyle.custom,
                    backgroundColor: Color(int.parse("FF"+snapshot.requireData[8]['data'] , radix: 16)),
                    color: PrimaryColors(),
                    badgeColor: Color(int.parse("FF"+snapshot.requireData[6]['data'] , radix: 16)),
                    activeColor: Color(int.parse("FF"+snapshot.requireData[6]['data'] , radix: 16)),
                    items: <TabItem>[
                      TabItem(icon: Icons.home,title: "Home"),
                      TabItem(icon: Icons.event,title: "My Work"),
                      TabItem(icon: Icons.person,title: "Profile"),
                    ],
                    onTap: (int i) => _navigationBottomBar(i),
                  )
              ),
            );
          }else{
            return Loading();
          }
        },
      ),
    );
  }
}
