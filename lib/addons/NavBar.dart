import 'package:flutter/material.dart';
import 'package:palmer/AccountScreen.dart';
import 'package:palmer/HomeScreen.dart';
import 'package:palmer/Notifications_Screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Muhammad Ahmed'),
            accountEmail: Text(
              'ahmedmuhammad@gmail.com',
              style: TextStyle(color: Colors.amberAccent),
            ),
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
            title: Text('ToDo'),
            onTap: () {},
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
        ],
      ),
    );
  }
}
