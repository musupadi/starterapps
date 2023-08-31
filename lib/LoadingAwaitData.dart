import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingAwaitData extends StatefulWidget {
  const LoadingAwaitData({Key? key}) : super(key: key);

  @override
  State<LoadingAwaitData> createState() => _LoadingAwaitDataState();
}

class _LoadingAwaitDataState extends State<LoadingAwaitData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
                "assets/lottie/animationload.json",
                width: 300,
                height: 300,
                repeat: true,
                fit: BoxFit.fill
            ),
            Text(
              "Please Wait for Loading",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 15
              ),
            )
          ],
        ),
      ),
    );
  }
}
