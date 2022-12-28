// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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

class MyHome extends StatefulWidget {
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List Sliderimglist = [
    {"id": 1, "image_path": 'images/img_slider1.jpg'},
    {"id": 2, "image_path": 'images/img_slider2.jpg'},
    {"id": 3, "image_path": 'images/img_slider3.jpg'}
  ];

  final CarouselController carouselControl = CarouselController();

  int currentindex = 0;

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
            // GestureDetector(
            //   child: Container(
            //     margin: EdgeInsets.symmetric(horizontal: 15),
            //     child: Icon(Icons.search),
            //   ),
            //   onTap: () {
            //     showSearch(context: context, delegate: CustomSearchDelegate());
            //   },
            // ),
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
              // SLider Working =================
              Stack(
                children: [
                  InkWell(
                    onTap: () {
                      print(currentindex);
                    },
                    child: CarouselSlider(
                      items: Sliderimglist.map((item) => Image.asset(
                            item['image_path'],
                            fit: BoxFit.fill,
                            width: double.infinity,
                          )).toList(),
                      carouselController: carouselControl,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 2000),
                        enableInfiniteScroll: true,
                        aspectRatio: 2.5,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentindex = index;
                          });
                        },
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 10.0,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: Sliderimglist.asMap().entries.map((entry) {
                          // print(entry);
                          // print(entry.key);
                          return GestureDetector(
                            onTap: () =>
                                carouselControl.animateToPage(entry.key),
                            child: Container(
                              width: currentindex == entry.key ? 17 : 7,
                              height: 7.0,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 3.0,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: currentindex == entry.key
                                      ? Color.fromARGB(255, 255, 194, 101)
                                      : Colors.teal),
                            ),
                          );
                        }).toList(),
                      )),
                ],
              ),

              SizedBox(
                height: 60.0,
              ),

              //     --------------------- Home page Work -------------------------------------

              Row(
                children: [
                  Container(
                      child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/424/424162.png',
                    width: 0.0,
                    height: 30.0,
                  )),
                  Container(),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(children: []),
        ));
  }
}
