import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palmer/AdminControls/VeiwRequests.dart';
import 'package:palmer/AdminControls/addFlight.dart';
import 'package:palmer/AdminControls/addHotels.dart';
import 'package:palmer/AdminControls/addTransport.dart';
import 'package:palmer/AdminControls/viewUsers.dart';
import 'package:palmer/Login&Signup.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'ADMIN',
          style: TextStyle(color: Colors.teal),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScreenLoginSignup()));
                FirebaseAuth.instance.signOut();
              },
              child: Icon(
                Icons.exit_to_app,
                color: Colors.teal,
              ),
            ),
          )
        ],
      ),
      body: Container(
          child: GridView.count(
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        padding: EdgeInsets.all(20),
        primary: false,
        crossAxisCount: 2,
        children: <Widget>[
          InkWell(
            onTap: () {
              print('Hotels');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => addHotelScreen()));
            },
            child: Container(
              color: Colors.teal,
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hotels',
                        style: GoogleFonts.rubikBubbles(color: Colors.white))
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print('Flight');
            },
            child: Container(
              color: Colors.teal[300],
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('TIckets',
                        style: GoogleFonts.rubikBubbles(color: Colors.white))
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print('Transport');
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => addTransportScreen()));
            },
            child: Container(
              color: Colors.teal[300],
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Transport',
                        style: GoogleFonts.rubikBubbles(color: Colors.white))
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print('View Users');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ViewUserScreen()));
            },
            child: Container(
              color: Colors.teal[200],
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Users',
                        style: GoogleFonts.rubikBubbles(color: Colors.white))
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print('REQUESTS');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => VeiwRequestScreen()));
            },
            child: Container(
              color: Colors.teal[200],
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('REQUESTS',
                        style: GoogleFonts.rubikBubbles(color: Colors.white))
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print('FLIGHTS');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => addFlightScreen()));
            },
            child: Container(
              color: Colors.teal,
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(' FLIGHT',
                        style: GoogleFonts.rubikBubbles(color: Colors.white))
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
