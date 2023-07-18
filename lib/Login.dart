import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:project_management/Constant/Size.dart';
import 'package:project_management/Dashboard.dart';
import 'package:project_management/LoginIn.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Constant/colors.dart';
import 'Liblary/Ascendant.dart';
import 'Serverside/API.dart';
import 'Serverside/Server.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passenable = true; //boolean value to track password view enable disable.
  TextEditingController controllerUsername = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  TextEditingController controllerPassword2 = new TextEditingController();
  bool isLoading = false;
  LoginSuccess (String name){
    AwesomeDialog(
        context: context,
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: false,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: "Login Succes",
        desc: "Selamat Datang "+name,
        btnOkOnPress: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(seconds: 1),
                  transitionsBuilder: (
                      BuildContext context,
                      Animation<double> animation,
                      Animation<double> secAnimation,
                      Widget child) {
                    animation = CurvedAnimation(
                        parent: animation,
                        curve: Curves.elasticInOut
                    );
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                      alignment: Alignment.center,
                    );
                  },
                  pageBuilder: (
                      BuildContext context,
                      Animation<double> animation,
                      Animation<double> secAnimation
                      )
                  {
                    return Dashboard();
                  }
              )
          );
        },
        headerAnimationLoop: false
    )..show();
  }

  GmailRegister(String email,String password,String nama,String ImagePicture) async {
    int timeout = 5;
    setState(() => isLoading=true);
    try{
      final response = await http.post(
          Uri.parse(APIBaseURL()+RegisterGmail()),
          body: {
            "email": email,
            "password": password,
            "nama": nama,
            "image_picture": ImagePicture,
          }).timeout(Duration(seconds: timeout));
      setState(() => isLoading=false);
      if(jsonDecode(response.body)['code'] == 0){
        // Obtain shared preferences.
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('id', jsonDecode(response.body)['data'][0]['id_user'].toString());
        await prefs.setString('email', jsonDecode(response.body)['data'][0]['email'].toString());
        await prefs.setString('nama', jsonDecode(response.body)['data'][0]['nama'].toString());
        await prefs.setString('image_picture', jsonDecode(response.body)['data'][0]['image_picture'].toString());
        await prefs.setString('level', jsonDecode(response.body)['data'][0]['level'].toString());
        await prefs.setString('link_gmail', jsonDecode(response.body)['data'][0]['link_gmail'].toString());
        //
        //
        // String? token = prefs.getString('token_user');
        // String? level = prefs.getString("level");
        // String? nama = prefs.getString("nama_user");
        // String? id_user = prefs.getString("id_user");
        LoginSuccess(nama.toString());
      }else{
        FailedMessage("Terjadi Kesalahan", jsonDecode(response.body)['Message'].toString(), context);
      }
    } on TimeoutException catch (e){
      setState(() => isLoading=false);
      FailedMessage("Login Failed", "Koneksi Gagal",context);
    } on SocketException catch (e){
      setState(() => isLoading=false);
      FailedMessage("Login Failed", "Socket Salah : "+e.toString(),context);
    } on Error catch (e){
      // FailedMessage("Login Failed", e.toString(),context);
      print("Zyarga Debugger : "+e.toString());
      setState(() => isLoading=false);
      // FailedMessage("Login Failed", "Error karena : "+e.toString(),context);
    }
  }
  GmailLogin(String nama,String email,String ProfilePicture) async{
    int timeout = 5;
    setState(() => isLoading=true);
    // LoadingMessage("Mencoba Login", "Sedang Mencoba Login", context);
    try{
      final response = await http.post(
          Uri.parse(APIBaseURL()+LoginGmail()), body: {
        "email": email,
      }).timeout(Duration(seconds: timeout));
      setState(() => isLoading=false);
      print("Zyarga Debugger : "+response.body.toString());
      if(jsonDecode(response.body)['code'] == 0){
        // Obtain shared preferences.
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('id_user', jsonDecode(response.body)['data'][0]['id_user'].toString());
        await prefs.setString('email', jsonDecode(response.body)['data'][0]['email'].toString());
        await prefs.setString('nama', jsonDecode(response.body)['data'][0]['nama'].toString());
        await prefs.setString('image_picture', jsonDecode(response.body)['data'][0]['image_picture'].toString());
        await prefs.setString('level', jsonDecode(response.body)['data'][0]['level'].toString());
        await prefs.setString('link_gmail', jsonDecode(response.body)['data'][0]['link_gmail'].toString());
        //
        //
        // String? token = prefs.getString('token_user');
        // String? level = prefs.getString("level");
        String? s = prefs.getString("nama");
        // String? id_user = prefs.getString("id_user");
        LoginSuccess(s.toString());
      }else{
        setState(() => isLoading=false);
        AwesomeDialog(
            context: context,
            dismissOnTouchOutside: true,
            dismissOnBackKeyPress: false,
            dialogType: DialogType.noHeader,
            animType: AnimType.scale,
            body: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: PrimaryColors(),width: 1),
                    image: DecorationImage(image: NetworkImage(ProfilePicture))
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                    nama,
                    style: TextStyle(
                      color: PrimaryColors(),
                      fontSize: FontSizeLarge(),
                      fontWeight: FontWeight.bold
                    ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Please input your new Password"),
                Container(
                    child: TextField(
                      controller: controllerPassword2,
                      decoration: InputDecoration(
                          hintText: 'Password...',
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                              icon: passenable
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: () =>
                                  setState(() => passenable = !passenable)
                          )
                      ),
                      obscureText: passenable,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                    )
                ),
              ],
            ),
            btnOkOnPress: () {
              GmailRegister(email, controllerPassword2.text, nama, ProfilePicture);
            },
            headerAnimationLoop: false
        )..show();
      }
      return jsonDecode(response.body)['data'][0]['nama'].toString();
    } on TimeoutException catch (e){
      setState(() => isLoading=false);
      FailedMessage("Login Failed", "Koneksi Gagal",context);
    } on SocketException catch (e){
      setState(() => isLoading=false);
      FailedMessage("Login Failed", "Socket Salah : "+e.toString(),context);
    } on Error catch (e){
      // FailedMessage("Login Failed", e.toString(),context);
      print("Zyarga Debugger : "+e.toString());
      setState(() => isLoading=false);
      // FailedMessage("Login Failed", "Error karena : "+e.toString(),context);
    }
  }


  @override
  Widget build(BuildContext context){
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Container(
              color: SecondaryColors(),
            ),
            Container(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: double.infinity,
                          child: Center(
                            child: Lottie.asset(
                              "assets/lottie/project_management.json",
                              width: 200,
                              height: 200,
                            ),
                          ),
                      ),
                      Text("Project Management",
                        style: TextStyle(
                            color: PrimaryColors(),
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: PrimaryColors(),
                        height: 50,
                        width: double.infinity,
                        child: Center(
                            child: new Text("Login",
                              style: TextStyle(color: Colors.white,fontSize: 20),
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  color: Colors.grey,
                                  offset: Offset(0,2),
                                  spreadRadius: 2
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: SingleChildScrollView(
                              child: new Column(
                                children: <Widget>[
                                  Container(
                                      child: TextField(
                                        controller: controllerUsername,
                                        decoration: InputDecoration(
                                            hintText: 'contoh@gmail.com',
                                            prefixIcon: Icon(Icons.mail),
                                            labelText: 'Username',
                                            border: OutlineInputBorder(),
                                            suffixIcon: controllerUsername.text.isEmpty ? Container(width: 0,): IconButton(
                                              icon: Icon(
                                                  Icons.close,
                                                  color: Colors.red),
                                              onPressed: ()=> controllerUsername.clear(),
                                            )
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                        textInputAction: TextInputAction.done,
                                      )
                                  ),
                                  SizedBox(height: 30,),
                                  Container(
                                      child: TextField(
                                        controller: controllerPassword,
                                        decoration: InputDecoration(
                                            hintText: 'Password...',
                                            prefixIcon: Icon(Icons.lock),
                                            labelText: 'Password',
                                            border: OutlineInputBorder(),
                                            suffixIcon: IconButton(
                                                icon: passenable
                                                    ? Icon(Icons.visibility_off)
                                                    : Icon(Icons.visibility),
                                                onPressed: () =>
                                                    setState(() => passenable = !passenable)
                                            )
                                        ),
                                        obscureText: passenable,
                                        keyboardType: TextInputType.emailAddress,
                                        textInputAction: TextInputAction.done,
                                      )
                                  ),
                                  SizedBox(height: 30,),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        width: 200,
                                        height: 50,
                                        child: ElevatedButton.icon(
                                          style: ButtonStyle(
                                            elevation: MaterialStatePropertyAll(10),
                                            backgroundColor: MaterialStateProperty.all(PrimaryColors()),
                                          ),
                                          label: Text("Login",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white
                                            ),
                                          ),
                                          icon: Icon(Icons.login),
                                          onPressed: () async {
                                            // Navigator.of(context).push(
                                            //   new MaterialPageRoute(builder: (BuildContext context) => homepage() )
                                            // );
                                            // Logins();
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        width: 200,
                                        height: 50,
                                        child: ElevatedButton.icon(
                                          style: ButtonStyle(
                                            elevation: MaterialStatePropertyAll(10),
                                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                                          ),
                                          label: Text("Login Via Google",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white
                                            ),
                                          ),
                                          icon: Icon(Icons.g_mobiledata,color: Colors.white,),
                                          onPressed: () async {
                                            _googleSignIn.signIn().then((value) {
                                              String userName = value!.displayName!;
                                              String profilePicture = value!.photoUrl!;
                                              String email = value!.email;
                                              GmailLogin(userName,email,profilePicture);
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if(isLoading)
              Stack(
                  children:[
                    Container(
                        color: Colors.black.withOpacity(0.5)
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: SpinKitFoldingCube(
                              color: Colors.white,
                              size: 50,
                            )
                        ),
                        SizedBox(width: double.infinity, height: 20,),
                        Text("Sedang Mencoba Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                        )
                      ],
                    )
                  ]
              ),
          ],
        ),
      ),
    );
  }
}
