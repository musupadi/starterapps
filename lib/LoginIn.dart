
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
class LoginIn extends StatefulWidget {
  const LoginIn({Key? key}) : super(key: key);

  @override
  State<LoginIn> createState() => _LoginInState();
}

class _LoginInState extends State<LoginIn> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: (){
              _googleSignIn.signIn().then((value) {
                String userName = value!.displayName!;
                String profilePicture = value!.photoUrl!;
                String ID = value!.email;
                print("Zyarga Debugger : "+ID);
              }
            );
          },
          color: Colors.red,
          height: 50,
          minWidth: 100,
          child: const Text(
            'Google Signin',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
