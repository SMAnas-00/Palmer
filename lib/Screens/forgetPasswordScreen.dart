import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:palmer/main.dart';

import '../addons/round_button.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final BackArrow = IconButton(
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
    return Scaffold(
      appBar: AppBar(
        leading: BackArrow,
        backgroundColor: Colors.teal[300],
        title: const Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your email';
                  }
                  if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+$')
                      .hasMatch(value)) {
                    return 'Enter correct email';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 17.0),
                  suffixIcon: Icon(
                    Icons.email,
                    color: Colors.teal,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RoundButton(
                  title: "Forgot",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      auth
                          .sendPasswordResetEmail(
                              email: emailController.text.toString())
                          .then((value) {
                        emailController.clear();
                        displayMessage(
                            "We have sent email to recover password, please check email");
                      }).onError((error, stackTrace) {
                        displayMessage(error.toString());
                      });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
