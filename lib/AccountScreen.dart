// ignore_for_file: prefer_const_constructors, file_names, camel_case_types

import 'package:flutter/material.dart';
import 'addons/DrawerMenu.dart';
import 'addons/SearchBar.dart';
import 'login_Screen.dart';

class account_Page extends StatefulWidget {
  const account_Page({super.key});

  @override
  State<account_Page> createState() => _account_PageState();
}

class _account_PageState extends State<account_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 253, 252),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 194, 101)),
        backgroundColor: Color.fromARGB(255, 254, 253, 252),
        title: Text(
          'Account',
          style: TextStyle(color: Color.fromARGB(255, 29, 165, 153)),
        ),
        actions: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(Icons.search),
            ),
            onTap: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 2, 0),
              child: Icon(Icons.account_circle),
            ),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          )
        ],
      ),
      drawer: Drawer(child: Drawer_menu()),
      body: Center(),
    );
  }
}
