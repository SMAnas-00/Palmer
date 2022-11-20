import 'package:flutter/material.dart';

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
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

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
