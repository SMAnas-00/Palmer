import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palmer/AdminControls/AdminDash.dart';
import 'package:palmer/HomeScreen.dart';
import 'package:palmer/Login&Signup.dart';
import 'package:palmer/Signup.dart';
import 'package:palmer/addons/round_button.dart';
import 'package:palmer/main.dart';
import 'AccountScreen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // here we have the id of login user...
  var userid;
  final _formKey = GlobalKey<FormState>();
  final emailcontrol = TextEditingController();
  final passwordcontrol = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  login() async {
    Future<UserCredential> usercred = auth.signInWithEmailAndPassword(
        email: emailcontrol.text, password: passwordcontrol.text);

    final user = auth.currentUser;

    final dbuser = await FirebaseFirestore.instance
        .collection('app')
        .doc('Users')
        .collection('Signup')
        .doc(user?.uid)
        .get();

    if (dbuser.data()?['Role'] == 'admin') {
      Navigator.pushNamed(context, '/admindash');
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => AdminPanel()));
      // Get.off(() => AdminPanel());
    } else if (dbuser.data()?['Role'] == 'user') {
      Navigator.pushNamed(context, '/userdash');
      // Get.off(() => MyHome());
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => MyHome()));
    } else {
      Navigator.pop(context);
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (context) => ScreenLoginSignup()));
      // Get.off(() => ScreenLoginSignup());
    }
    emailcontrol.clear();
    passwordcontrol.clear();
  }

  @override
  Widget build(BuildContext context) {
    final BackArrow = IconButton(
        color: Color.fromARGB(255, 255, 194, 101),
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));

    return Scaffold(
      appBar: AppBar(
        leading: BackArrow,
        automaticallyImplyLeading: true,
        title: Text(
          'LOGIN',
          style: TextStyle(color: Color.fromARGB(255, 29, 165, 153)),
        ),
        backgroundColor: Color.fromARGB(255, 254, 253, 252),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // email text box
                      TextFormField(
                        controller: emailcontrol,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.alternate_email),
                        ),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            //allow upper and lower case alphabets and space
                            return "Enter Correct Name";
                          } else {
                            return null;
                          }
                        },
                      ),

                      //space
                      SizedBox(
                        height: 20,
                      ),

                      // password text box
                      TextFormField(
                        controller: passwordcontrol,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.password_sharp),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Password';
                          } else {
                            return null;
                          }
                        },
                      ),

                      SizedBox(
                        height: 50,
                      ),
                    ],
                  )),
              // Submit Button
              RoundButton(
                title: "LOGIN",
                onTap: () {
                  login();
                },
              ),
              const SizedBox(height: 30.0),

              // Create New Account Button
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: const Text(
                    'CREATE NEW ACCOUNT',
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
              )
            ]),
      ),
    );
  }
}


// class UserManagment {
//   Widget handleAuth() {
//     return StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (BuildContext context, snapshot) {
//           if (snapshot.hasData) {
//             return MyHome();
//           }
//           return ScreenLoginSignup();
//         });
//   }
//   authorizeAccess(BuildContext context){
//      FirebaseAuth.instance.currentUser.then((user){
//      });
//   }
// }
