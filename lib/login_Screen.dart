import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:palmer/HomeScreen.dart';
import 'package:palmer/Signup.dart';
import 'package:palmer/addons/round_button.dart';
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

  @override
  void dispose() {
    super.dispose();
    emailcontrol.dispose();
    passwordcontrol.dispose();
  }

  Future<void> login() async {
    UserCredential usercred = auth.signInWithEmailAndPassword(
        email: emailcontrol.text,
        password: passwordcontrol.text) as UserCredential;
    userid = usercred.user!.uid;
    //     .then((value) {
    //   print("Login");
    // }).onError((error, stackTrace) {
    //   print(error.toString());
    // });
  }

  @override
  Widget build(BuildContext context) {
    final BackArrow = IconButton(
        color: Color.fromARGB(255, 255, 194, 101),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => account_Page()));
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
                          if (value!.isEmpty) {
                            return 'Enter Email';
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
                  if (_formKey.currentState!.validate()) {
                    login();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  }
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
              )
            ]),
      ),
    );
  }
}
