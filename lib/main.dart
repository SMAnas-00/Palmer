import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:palmer/HomeScreen.dart';
import 'package:palmer/Login&Signup.dart';
import 'package:palmer/Signup.dart';
import 'package:palmer/WelcomeScreen.dart';

import 'login_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

displayMessage(String message) {
  Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Buildingapp(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // '/': (context) => const Buildingapp(),
        '/login': (context) => Login(),
        '/signup': (context) => SignUp(),
        '/userdash': (context) => MyHome(),
      },
    );
  }
}

class Buildingapp extends StatefulWidget {
  const Buildingapp({super.key});

  @override
  State<Buildingapp> createState() => _BuildingappState();
}

class _BuildingappState extends State<Buildingapp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot) {
      // check for Error
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Something Went Wrong!'));
      } else if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasData) {
          print(snapshot.data.toString());
          return MyHome();
        }

        return Splash();
      } else {
        return const Splash();
      }
    });
    ;
  }
}
