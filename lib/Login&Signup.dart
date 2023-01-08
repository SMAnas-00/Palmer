import 'package:flutter/material.dart';
import 'package:palmer/AdminControls/AdminDash.dart';
import 'package:palmer/AdminControls/addFlight.dart';
import 'package:palmer/Cart/CartScreen.dart';
import 'package:palmer/HomeScreen.dart';
import 'package:palmer/Services/Tickets/Flight.dart';
import 'package:palmer/Signup.dart';
import 'package:palmer/WelcomeScreen.dart';
import 'package:palmer/login_Screen.dart';

class ScreenLoginSignup extends StatefulWidget {
  const ScreenLoginSignup({super.key});

  @override
  State<ScreenLoginSignup> createState() => _ScreenLoginSignupState();
}

class _ScreenLoginSignupState extends State<ScreenLoginSignup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                'images/mainicon.png',
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[400],
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.5,
                      MediaQuery.of(context).size.height * 0.08),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('LOGIN'),
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[400],
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.5,
                      MediaQuery.of(context).size.height * 0.08),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text('SIGNUP'),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => addFlightScreen()));
                },
                child: Text('Practice'))
          ],
        ),
      ),
    );
  }
}
