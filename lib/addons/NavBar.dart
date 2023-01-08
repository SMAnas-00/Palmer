import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:palmer/AccountScreen.dart';
import 'package:palmer/HomeScreen.dart';
import 'package:palmer/Login&Signup.dart';
import 'package:palmer/Notifications_Screen.dart';
import 'package:palmer/Services/Hotels/Hotels.dart';
import 'package:palmer/Services/Tickets/Flight.dart';
import 'package:palmer/Services/Transport/Transport.dart';
import 'package:palmer/main.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(''),
            accountEmail:
                Text('no email', style: TextStyle(color: Colors.amberAccent)),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'images/image04.jpg',
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 29, 165, 153),
              Color.fromARGB(255, 155, 207, 203)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ),
          ListTile(
            leading: Icon(Icons.dashboard_outlined),
            title: Text('DashBoard'),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MyHome()));
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text('Account'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => account_Page()));
            },
          ),
          ListTile(
            leading: Icon(Icons.playlist_add_check_outlined),
            title: Text('Todo'),
            onTap: () {},
          ),
          Divider(),
          SizedBox(height: 10),
          ListTile(
            leading: Icon(Icons.hotel_outlined),
            title: Text('Hotels'),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Hotels()));
            },
          ),
          ListTile(
            leading: Icon(Icons.emoji_transportation_outlined),
            title: Text('Transport'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => TransportService()));
            },
          ),
          ListTile(
            leading: Icon(Icons.flight_takeoff_outlined),
            title: Text('FLIGHT'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => FlightScreen()));
            },
          ),
          Divider(),
          SizedBox(
            height: 20.0,
          ),
          ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text('Settings'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Notification_page()));
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications_outlined),
            title: Text('Notifictions'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Notification_page()));
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications_outlined),
            title: Text('SignOut'),
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScreenLoginSignup())));
            },
          ),
        ],
      ),
    );
  }
}
