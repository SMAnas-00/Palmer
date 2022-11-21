import 'package:flutter/material.dart';
import 'package:palmer/addons/round_button.dart';
import 'AccountScreen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailcontrol = TextEditingController();
  final passwordcontrol = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailcontrol.dispose();
    passwordcontrol.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BackArrow = IconButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => account_Page()));
        },
        icon: Icon(Icons.arrow_back));

    return Scaffold(
      appBar: AppBar(
        leading: BackArrow,
        automaticallyImplyLeading: true,
        title: Text('LOGIN'),
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
                        obscuringCharacter: '*',
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
              RoundButton(
                title: "login",
                onTap: () {
                  if (_formKey.currentState!.validate()) {}
                },
              )
            ]),
      ),
    );
  }
}
