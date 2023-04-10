import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:palmer/AdminControls/AdminDash.dart';
import 'package:palmer/Cart/CartScreen.dart';
import 'package:palmer/Screens/AccountScreen.dart';
import 'package:palmer/Screens/HomeScreen.dart';
import 'package:palmer/Screens/Login&Signup.dart';
import 'package:palmer/Screens/Signup.dart';
import 'package:palmer/Screens/WelcomeScreen.dart';
import 'package:palmer/Screens/forgetPasswordScreen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'Screens/login_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Initialize the timezone.
  tz.initializeTimeZones();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

displayMessage(String message) {
  Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // '/': (context) => const Buildingapp(),
        '/account': (context) => account_Page(),
        '/login': (context) => Login(),
        '/forget': (context) => ForgetPassScreen(),
        '/signup': (context) => SignUp(),
        '/userdash': (context) => MyHome(),
        '/admindash': (context) => AdminPanel(),
        '/cart': (context) => Cart(),
      },
    );
  }
}

// class Buildingapp extends StatefulWidget {
//   const Buildingapp({super.key});

//   @override
//   State<Buildingapp> createState() => _BuildingappState();
// }

// class _BuildingappState extends State<Buildingapp> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           // check for Error
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Something Went Wrong!'));
//           } else if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasData) {
//               print(snapshot.data.toString());
//               return MyHome();
//             }

//             return Splash();
//           } else {
//             return const Splash();
//           }
//         });
//     ;
//   }
// }
