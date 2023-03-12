import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:palmer/Screens/login_Screen.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _fname_control = TextEditingController();
  final _lname_control = TextEditingController();
  final _password1_control = TextEditingController();
  final _password2_control = TextEditingController();
  final _email_control = TextEditingController();
  final _contact_control = TextEditingController(text: "+92");
  final _address_control = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    super.dispose();
    _fname_control.dispose();
    _lname_control.dispose();
    _password1_control.dispose();
    _password2_control.dispose();
    _email_control.dispose();
    _contact_control.dispose();
    _address_control.dispose();
  }

  signup() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: _email_control.text, password: _password2_control.text)
          .then((value) {
        final user = auth.currentUser;
        final uid = user?.uid;
        firestore
            .collection("app")
            .doc("Users")
            .collection("Signup")
            .doc(uid)
            .set({
          'First_name': _fname_control.text,
          'Last_name': _lname_control.text,
          'Email': _email_control.text,
          'Contact': _contact_control.text,
          'Password': _password2_control.text,
          'Address': _address_control.text,
          'Role': 'user',
          'Created_by': "user",
          'Active_lock': "1",
          'Modified_by': "user",
          'Modified_date': DateTime.now().millisecondsSinceEpoch,
          'Status': "Active",
          'id': uid,
        });
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    _fname_control.clear();
    _lname_control.clear();
    _email_control.clear();
    _contact_control.clear();
    _password1_control.clear();
    _password2_control.clear();
    _address_control.clear();
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
        title: const Text(
          'Sign-Up',
          style: TextStyle(color: Color.fromARGB(255, 29, 165, 153)),
        ),
        backgroundColor: Color.fromARGB(255, 254, 253, 252),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            // Create New! text
            Center(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: const Text(
                  'Create New!',
                  style: TextStyle(
                    color: Color.fromARGB(255, 29, 165, 153),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Form Area
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    // First Name feild =======================
                    TextFormField(
                      controller: _fname_control,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          hintText: 'First Name',
                          prefixIcon: Icon(Icons.person)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your name";
                        }
                        if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                          return "Enter correct name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12.0),

                    // Lastname feild =======================
                    TextFormField(
                      controller: _lname_control,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          hintText: 'Last Name',
                          prefixIcon: Icon(Icons.person_add)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your name";
                        }
                        if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                          return "Enter correct name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12.0),

                    // contact feild =======================
                    TextFormField(
                      controller: _contact_control,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          hintText: 'Contact',
                          prefixIcon: Icon(Icons.contact_phone_rounded)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter phone number";
                        }
                        if (!RegExp(r'(^(?:[+0]9)?[0-9]{11}$)')
                            .hasMatch(value)) {
                          return "Enter correct number";
                        }
                        if (value.startsWith("0")) {
                          return "Please start with country code";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12.0),

                    // Email feild =======================
                    TextFormField(
                        controller: _email_control,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.email_rounded)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your email';
                          }
                          if (!RegExp(
                                  r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+$')
                              .hasMatch(value)) {
                            return 'Enter correct email';
                          }
                          return null;
                        }),
                    SizedBox(height: 12.0),

                    // Password feild =======================
                    TextFormField(
                      controller: _password1_control,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.password_rounded)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value != null && value.length < 8
                          ? 'Enter min. 8 characters'
                          : null,
                    ),
                    SizedBox(height: 12.0),

                    // Retype Password feild =======================
                    TextFormField(
                        controller: _password2_control,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: 'Retype Password',
                            prefixIcon: Icon(Icons.password_rounded)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please confirm password";
                          }
                          if (value != _password1_control.text) {
                            return "Password does not match";
                          }
                          return null;
                        }),
                    SizedBox(height: 12.0),

                    // address feild =============
                    TextFormField(
                      controller: _address_control,
                      keyboardType: TextInputType.streetAddress,
                      decoration: const InputDecoration(
                          hintText: 'Address',
                          prefixIcon: Icon(Icons.location_city_rounded)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Address';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                  ],
                ),
              ),
            ),
            // Sign up  Button ===============
            ElevatedButton(
              onPressed: () {
                signup();
              },
              child: const Text(
                'Submit',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                  elevation: 12.0,
                  backgroundColor: Color.fromARGB(255, 29, 165, 153)),
            ),
          ],
        ),
      ),
    );
  }
}