// ignore_for_file: file_names, camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';

import '../AccountScreen.dart';
import '../HomeScreen.dart';

class Drawer_menu extends StatefulWidget {
  const Drawer_menu({super.key});

  @override
  State<Drawer_menu> createState() => _Drawer_menuState();
}

class _Drawer_menuState extends State<Drawer_menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 29, 165, 153),
      child: ListView(
        padding: EdgeInsets.fromLTRB(10, 40, 0, 0),
        children: [
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          ListTile(
            title: Text('Account'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => account_Page()));
            },
          )
        ],
      ),
    );
  }
}
