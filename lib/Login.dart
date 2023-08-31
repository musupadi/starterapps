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
import 'package:project_management/Loading.dart';
import 'package:project_management/LoginIn.dart';
import 'package:http/http.dart' as http;
import 'package:project_management/Serverside/APIData.dart';
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
  late String id_domain = "";
  late String domain = "";
  Future<List> getDomain() async {
    final response=await http.get(
        Uri.parse(
            APIBaseURL()+
                DataDomain()
        ),
    ).timeout(Duration(seconds: 5));
    return json.decode(response.body)['data'];
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDomain();
  }
  bool passenable = true; //boolean value to track password view enable disable.
  TextEditingController controllerUsername = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  TextEditingController controllerPassword2 = new TextEditingController();
  bool isLoading = false;

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
        LoginSuccess(context,nama.toString());
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
        LoginSuccess(context,s.toString());
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
                    image: DecorationImage(image: NetworkImage(ProfilePicture == "" || ProfilePicture == null || ProfilePicture == "null"? BaseURL()+"pu_logo.png" : ProfilePicture))
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


  // Future<String> getIdPreset() async{
  //   final response=await http.get(
  //     Uri.parse(
  //         APIBaseURL()+
  //             getDesign()
  //     ),
  //   ).timeout(Duration(seconds: 5));
  //   return json.decode(response.body)['data'][0]['id_design'];
  // }
  // Future<List> getCustomPreset() async{
  //   final response=await http.get(
  //     Uri.parse(
  //         APIBaseURL()+
  //             getCustomDesign(await getIdPreset())
  //     ),
  //   ).timeout(Duration(seconds: 5));
  //   return json.decode(response.body)['data'];
  // }

  @override
  Widget build(BuildContext context){
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
          future: getDomain(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return FutureBuilder(
                future: getCustomPreset(),
                builder: (context, snapshots) {
                  if(snapshots.hasData){
                    return Stack(
                      children: [
                        Container(
                          color: Color(int.parse("FF"+snapshots.requireData[5]['data'] , radix: 16)),
                        ),
                        SafeArea(
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  child: Center(
                                      child: Image.network(
                                        BaseURL()+snapshots.requireData[0]['data'],
                                        height: 200,
                                        width: 200,
                                      )
                                  ),
                                ),
                                Text("Project Management",
                                  style: TextStyle(
                                      color: Color(int.parse("FF"+snapshots.requireData[9]['data'] , radix: 16)),
                                      fontWeight: FontWeight.bold,
                                      fontSize: double.parse(snapshots.requireData[4]['data'])
                                  ),

                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  color: Color(int.parse("FF"+snapshots.requireData[6]['data'] , radix: 16)),
                                  height: 50,
                                  width: double.infinity,
                                  child: Center(
                                      child: new Text("Login",
                                        style: TextStyle(
                                            color: Color(int.parse("FF"+snapshots.requireData[8]['data'] , radix: 16)),
                                            fontSize: double.parse(snapshots.requireData[3]['data'])
                                        ),
                                      )
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(int.parse("FF"+snapshots.requireData[8]['data'] , radix: 16)),
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
                                                      backgroundColor: MaterialStateProperty.all(Color(int.parse("FF"+snapshots.requireData[6]['data'] , radix: 16)),),
                                                    ),
                                                    label: Text("Login",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Color(int.parse("FF"+snapshots.requireData[8]['data'] , radix: 16)),
                                                      ),
                                                    ),
                                                    icon: Icon(Icons.login),
                                                    onPressed: () async {
                                                      LoginData(context,controllerUsername.text,controllerPassword.text);
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            InkWell(
                                              onTap: () {
                                                _googleSignIn.signIn().then((value) {
                                                  String userName = value!.displayName!;
                                                  String? profilePicture = value.photoUrl;
                                                  String email = value!.email;
                                                  for(int i=0;i<snapshot.requireData.length;i++){
                                                    if(email.substring(email.indexOf("@")+1) != snapshot.requireData[i]['domain']){
                                                      Message("Email Domain not Found", context);
                                                    }else{
                                                      print("Zyarga Debugger "+profilePicture.toString());
                                                      GmailLogin(userName, email, profilePicture.toString());
                                                    }
                                                  }
                                                });
                                              },
                                              child: Container(
                                                width: 200,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.white54,
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 0.3
                                                    )
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: <Widget>[
                                                      Image(
                                                        image: AssetImage("assets/img/logo_google.png"),
                                                        width: 25,
                                                        height: 25,
                                                        fit: BoxFit.fill,
                                                      ),
                                                      Text(
                                                        "Sign in With Google",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
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
                    );
                  }else{
                    return Loading();
                  }
                },
              );
            }else{
              return Loading();
            }
          },
        ),
      ),
    );
  }
}
