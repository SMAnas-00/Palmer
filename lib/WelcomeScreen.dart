// ignore_for_file: file_names, prefer_const_constructors, use_build_context_synchronously, avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:palmer/Login&Signup.dart';

import 'HomeScreen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
    // _choice();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ScreenLoginSignup()));
  }

  // _choice() async {
  //   await StreamBuilder<User?>(
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         return Home();
  //       } else {
  //         LoginSignupScreen();
  //       }
  //       return CircularProgressIndicator();
  //     },
  //   );
  // }

// here we are making a splash screen....
// we use scaffold widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Image(
              image: AssetImage('images/mainicon.png'),
              width: MediaQuery.of(context).size.width * 0.50),
        )
      ],
    )));
  }
}
