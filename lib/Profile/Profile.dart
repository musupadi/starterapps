import 'package:flutter/material.dart';
import 'package:project_management/Constant/Size.dart';
import 'package:project_management/Constant/colors.dart';
import 'package:project_management/Liblary/Ascendant.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: SecondaryColors(),
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
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.white,width: 1),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(image_picture)
                          )
                      ),
                    ),
                    Text(
                      nama,
                      style: TextStyle(
                        color: PrimaryColors(),
                        fontWeight: FontWeight.bold,
                        fontSize: FontSizeLarge()
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      email,
                      style: TextStyle(
                          color: PrimaryColors(),
                          fontSize: FontSizeSmall()
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: PrimaryColors()
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            "Change Password",
                            style: TextStyle(
                              color: Colors.white,
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
                          color: PrimaryColors()
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            "Setting",
                            style: TextStyle(
                              color: Colors.white,
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
                          color: PrimaryColors()
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            "Privacy Policy",
                            style: TextStyle(
                              color: Colors.white,
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
  }
}
