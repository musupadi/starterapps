import 'package:flutter/material.dart';
import 'package:project_management/Constant/Size.dart';
import 'package:project_management/Constant/colors.dart';
import 'package:project_management/Liblary/Ascendant.dart';
import 'package:project_management/Liblary/SharedPreferance.dart';
import 'package:project_management/Loading.dart';
import 'package:project_management/Profile/Custom.dart';
import 'package:project_management/Route.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Serverside/Server.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String id_user = "";
  String email = "";
  String nama = "";
  String image_picture = "";
  String level = "";
  String link_gmail = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();

  }
  getDataUser() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("Zyarga Debugger : "+nama);
    setState(() {
      id_user = pref.getString("id_user")!;
      email = pref.getString("email")!;
      nama = pref.getString("nama")!;
      image_picture = pref.getString("image_picture")!;
      level = pref.getString("level")!;
      link_gmail = pref.getString("link_gmail")!;
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
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          FutureBuilder(
                            future: SharedImagePciture(),
                            builder: (context, Image) {
                              return Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Color(int.parse("FF"+snapshot.requireData[8]['data'] , radix: 16)),width: 1),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(Image.requireData == null || Image.requireData == "null" ? BaseURL()+snapshot.requireData[0]['data'] : Image.requireData)
                                    )
                                ),
                              );
                            },
                          ),
                          FutureBuilder(
                            future: SharedUserNama(),
                            builder: (context, name) {
                              return Text(
                                name.requireData,
                                style: TextStyle(
                                    color: Color(int.parse("FF"+snapshot.requireData[6]['data'] , radix: 16)),
                                    fontWeight: FontWeight.bold,
                                    fontSize: double.parse(snapshot.requireData[4]['data'])
                                ),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                          FutureBuilder(
                            future: SharedUserEmail(),
                            builder: (context, Email) {
                              return Text(
                                Email.requireData,
                                style: TextStyle(
                                    color: Color(int.parse("FF"+snapshot.requireData[6]['data'] , radix: 16)),
                                    fontSize: double.parse(snapshot.requireData[1]['data'])
                                ),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(int.parse("FF"+snapshot.requireData[6]['data'] , radix: 16)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Center(
                                child: Text(
                                  "Change Password",
                                  style: TextStyle(
                                    color: Color(int.parse("FF"+snapshot.requireData[8]['data'] , radix: 16)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(int.parse("FF"+snapshot.requireData[6]['data'] , radix: 16)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Center(
                                child: Text(
                                  "Setting",
                                  style: TextStyle(
                                    color: Color(int.parse("FF"+snapshot.requireData[8]['data'] , radix: 16)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(int.parse("FF"+snapshot.requireData[6]['data'] , radix: 16)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    "User management",
                                    style: TextStyle(
                                      color: Color(int.parse("FF"+snapshot.requireData[8]['data'] , radix: 16)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: level=="admin" ? true : false,
                            child: InkWell(
                              onTap: () {
                                toCustom(context);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(int.parse("FF"+snapshot.requireData[6]['data'] , radix: 16)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Center(
                                        child: Text(
                                          "Custom Design",
                                          style: TextStyle(
                                            color: Color(int.parse("FF"+snapshot.requireData[8]['data'] , radix: 16)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: level=="admin" ? true : false,
                            child: InkWell(
                              onTap: () {
                                toDomain(context);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(int.parse("FF"+snapshot.requireData[6]['data'] , radix: 16)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Center(
                                        child: Text(
                                          "Whitelist Domain",
                                          style: TextStyle(
                                            color: Color(int.parse("FF"+snapshot.requireData[8]['data'] , radix: 16)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(int.parse("FF"+snapshot.requireData[6]['data'] , radix: 16)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Center(
                                child: Text(
                                  "Privacy Policy",
                                  style: TextStyle(
                                    color: Color(int.parse("FF"+snapshot.requireData[8]['data'] , radix: 16)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(int.parse("FF"+snapshot.requireData[6]['data'] , radix: 16)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    "User Management",
                                    style: TextStyle(
                                      color: Color(int.parse("FF"+snapshot.requireData[8]['data'] , radix: 16)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              LogoutMessage("Logout", "Are You Sure want to Logout ?", context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    "Logout",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

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
