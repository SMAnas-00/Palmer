// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:palmer/Services/Api_Services.dart';
import 'package:palmer/addons/NavBar.dart';

import 'AccountScreen.dart';
import 'addons/SearchBar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HOME',
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 254, 253, 252),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 194, 101)),
          title: Text(
            'HOME',
            style: TextStyle(color: Color.fromARGB(255, 29, 165, 153)),
          ),
          backgroundColor: Color.fromARGB(255, 254, 253, 252),
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => account_Page()));
              },
            )
          ],
        ),
        drawer: NavBar(),
        body: Container(
          child: Column(
            children: [
              Center(
                child: Container(
                  child: Image.asset(
                    'images/image07.jpg',
                    height: 200.0,
                    width: 500.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              // Center(
              //   child: Container(
              //     margin: EdgeInsets.fromLTRB(50.0, 25.0, 50.0, 15.0),
              //     padding: EdgeInsets.all(2.0),
              //     child: Text(
              //       'kmcmadkmcmsdmckamlkmslcmslckmclksmcslkmckmscmalskmakcmkmakmclkmsd/n mcoalscmsamlasmal',
              //       style: TextStyle(
              //           fontSize: 15.0, fontWeight: FontWeight.normal),
              //     ),
              //   ),
              // )

              //     --------------------- Home page Work -------------------------------------
              Container(
                margin: EdgeInsets.fromLTRB(50.0, 0, 50.0, 5.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.amberAccent,
                              Color.fromARGB(255, 104, 99, 80)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.home), Text('Home')],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        children: [],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(children: []),
        ));
  }
}
