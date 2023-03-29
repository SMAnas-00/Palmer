import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palmer/Screens/AnimalBook.dart';
import 'package:palmer/Screens/tripScreen.dart';
import 'package:palmer/Services/Hotels/Hotels.dart';
import 'package:palmer/Services/Tickets/FlightDetails.dart';

import '../../Screens/HomeScreen.dart';
import '../Request.dart';

class FlightScreen extends StatefulWidget {
  const FlightScreen({super.key});

  @override
  State<FlightScreen> createState() => _FlightScreenState();
}

class _FlightScreenState extends State<FlightScreen> {
  Request request = Request();
  CollectionReference Flightitems = FirebaseFirestore.instance
      .collection('app')
      .doc('Services')
      .collection('Flight');

  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final BackArrow = IconButton(
        color: Colors.teal,
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AnimalBookingPage()));
        },
        icon: Icon(Icons.arrow_back));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackArrow,
          title: Text(
            'FLIGHTS',
            style: TextStyle(color: Colors.teal[300]),
          ),
          actions: [
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(right: 30),
                padding: EdgeInsets.all(20),
                child: Text(
                  'SKIP',
                  style: TextStyle(
                      color: Colors.teal, fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Hotels()));
              },
            )
          ],
        ),
        body: StreamBuilder(
          stream: Flightitems.snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: GestureDetector(
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: Image.network(
                                                snapshot.data!.docs[index]
                                                    ['flight_imageURL'],
                                                height: 70,
                                                width: 120,
                                              ),
                                            ),
                                            Text(snapshot.data!.docs[index]
                                                ['airline_name']),
                                          ],
                                        ),
                                        Text(
                                          snapshot.data!
                                                  .docs[index]['ticket_price']
                                                  .toString() +
                                              '/-',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(snapshot.data!.docs[index]
                                                ['departure'] +
                                            '\n' +
                                            snapshot.data!.docs[index]
                                                ['destination']),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              String airline_name =
                                  snapshot.data!.docs[index]['airline_name'];
                              String departure =
                                  snapshot.data!.docs[index]['departure'];
                              String destination =
                                  snapshot.data!.docs[index]['destination'];
                              String flightId = snapshot.data!.docs[index].id;
                              int flightPrice =
                                  snapshot.data!.docs[index]['ticket_price'];
                              String adminId =
                                  snapshot.data!.docs[index]['admin_id'];
                              String flight_imageURL =
                                  snapshot.data!.docs[index]['flight_imageURL'];
                              print('Flight >>>>>>>>>>>>>>>>>${flightId}');

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FlightDetails(
                                            airline_name: airline_name,
                                            departure: departure,
                                            destination: destination,
                                            flight_id: flightId,
                                            flightPrice: flightPrice,
                                            admin_id: adminId,
                                            flight_imageURL: flight_imageURL,
                                          )));
                            },
                          )),
                    );
                  }
                  return CircularProgressIndicator();
                });
          },
        ));
  }
}
