import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:palmer/Screens/AccountScreen.dart';
import 'package:palmer/Screens/HomeScreen.dart';
import 'package:palmer/Screens/Login&Signup.dart';
import 'package:palmer/Screens/TODO/TodoListScreen.dart';
import 'package:palmer/Screens/distanceCAL.dart';
import 'package:palmer/Screens/guideScreen.dart';
import 'package:palmer/main.dart';
import 'package:palmer/Screens/tripScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Screens/AnimalBook.dart';
import '../Screens/example.dart';
import '../Screens/map.dart';
import '../Screens/minaCamp.dart';
import '../Screens/weatherScreen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> getUserName() async {
    final uid = auth.currentUser?.uid;
    final users = await firestore
        .collection("app")
        .doc("Users")
        .collection("Signup")
        .doc(uid)
        .get();
    return '${users.data()?['First_name']} ${users.data()?['Last_name']}';
  }

  Future<String> getUserImage() async {
    final uid = auth.currentUser?.uid;
    final users = await firestore
        .collection("app")
        .doc("Users")
        .collection("Signup")
        .doc(uid)
        .get();
    return users.data()?['dp'];
  }

  _launchURL() async {
    const url = 'http://www.360tr.net/saudi-arabia/mecca-kaabe-al-masjid/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: 280,
      child: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 230,
              child: DrawerHeader(
                  child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    FutureBuilder(
                      future: getUserImage(),
                      builder: (_, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ClipOval(
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(48.0),
                              child: const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }
                        return Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(100)),
                          child: snapshot.data == ""
                              ? ClipOval(
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(48.0),
                                    child: const Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : ClipOval(
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(48.0),
                                    child:
                                        Image.network(snapshot.data.toString()),
                                  ),
                                ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FutureBuilder(
                      future: getUserName(),
                      builder: (_, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Text(snapshot.data);
                      },
                    )
                  ],
                ),
              )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyHome()));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.dashboard_outlined,
                  color: Colors.teal,
                ),
                title: Text("DASHBOARD"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const account_Page()));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.account_circle,
                  color: Colors.teal,
                ),
                title: Text("Profile"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const guideScreen()));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.help_center,
                  color: Colors.teal,
                ),
                title: Text("GUIDE"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ToDoScreen()));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.list_alt_sharp,
                  color: Colors.teal,
                ),
                title: Text("TODO LIST"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const BookTrip()));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.emoji_transportation_outlined,
                  color: Colors.teal,
                ),
                title: Text("BOOK YOUR TRIP"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CricketStadium()));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.cabin_sharp,
                  color: Colors.teal,
                ),
                title: Text("Mina CAMP"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                _launchURL();
              },
              child: const ListTile(
                leading: Icon(
                  Icons.map,
                  color: Colors.teal,
                ),
                title: Text("360 View"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapView()));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.map,
                  color: Colors.teal,
                ),
                title: Text("FIND"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyWeather()));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.cloudy_snowing,
                  color: Colors.teal,
                ),
                title: Text("Weather"),
              ),
            ),
            GestureDetector(
              onTap: () {
                auth.signOut().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScreenLoginSignup()));
                }).onError((error, stackTrace) {
                  displayMessage(error.toString());
                });
              },
              child: const ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.teal,
                ),
                title: Text("Sign out"),
              ),
            ),
          ],
        ),
      ),
    ));
    // return Drawer(
    //   child: ListView(
    //     padding: EdgeInsets.zero,
    //     children: [
    //       FutureBuilder(
    //         future: getUserName(),
    //         builder: (_, AsyncSnapshot snapshot) {
    //           if (snapshot.connectionState == ConnectionState.waiting) {
    //             return const Center(
    //               child: CircularProgressIndicator(),
    //             );
    //           }
    //           return Text(snapshot.data);
    //         },
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.dashboard_outlined),
    //         title: Text('DashBoard'),
    //         onTap: () {
    //           Navigator.pushReplacement(
    //               context, MaterialPageRoute(builder: (context) => MyHome()));
    //         },
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.account_circle_outlined),
    //         title: Text('Account'),
    //         onTap: () {
    //           Navigator.pushNamed(context, '/account');
    //         },
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.playlist_add_check_outlined),
    //         title: Text('Todo'),
    //         onTap: () {},
    //       ),
    //       Divider(),
    //       SizedBox(height: 10),
    //       // ListTile(
    //       //   leading: Icon(Icons.hotel_outlined),
    //       //   title: Text('Hotels'),
    //       //   onTap: () {
    //       //     Navigator.pushReplacement(
    //       //         context, MaterialPageRoute(builder: (context) => Hotels()));
    //       //   },
    //       // ),
    //       ListTile(
    //         leading: Icon(Icons.emoji_transportation_outlined),
    //         title: Text('BOOK YOUR TRIP'),
    //         onTap: () {
    //           Navigator.pushReplacement(
    //               context, MaterialPageRoute(builder: (context) => BookTrip()));
    //         },
    //       ),
    //       // ListTile(
    //       //   leading: Icon(Icons.flight_takeoff_outlined),
    //       //   title: Text('FLIGHT'),
    //       //   onTap: () {
    //       //     Navigator.pushReplacement(context,
    //       //         MaterialPageRoute(builder: (context) => FlightScreen()));
    //       //   },
    //       // ),
    //       Divider(),
    //       SizedBox(
    //         height: 20.0,
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.settings_outlined),
    //         title: Text('Settings'),
    //         onTap: () {
    //           Navigator.pushReplacement(context,
    //               MaterialPageRoute(builder: (context) => Notification_page()));
    //         },
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.notifications_outlined),
    //         title: Text('Notifictions'),
    //         onTap: () {
    //           Navigator.pushReplacement(context,
    //               MaterialPageRoute(builder: (context) => Notification_page()));
    //         },
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.notifications_outlined),
    //         title: Text('SignOut'),
    //         onTap: () {
    //           FirebaseAuth.instance.signOut().then((value) =>
    //               Navigator.pushReplacement(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (context) => ScreenLoginSignup())));
    //         },
    //       ),
    //     ],
    //   ),
    // );
  }
}
