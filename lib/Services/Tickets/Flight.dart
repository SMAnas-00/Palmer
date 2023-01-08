import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../HomeScreen.dart';
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
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHome()));
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
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(snapshot.data!.docs[index]
                                          ['airline_name']),
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
                                      ElevatedButton(
                                          onPressed: () {
                                            final reqid =
                                                '${auth.currentUser!.uid}';
                                            request.Ticketreq(
                                                reqid,
                                                snapshot.data!.docs[index]
                                                    ['airline_name'],
                                                snapshot.data!.docs[index]
                                                    ['departure'],
                                                snapshot.data!.docs[index]
                                                    ['destination'],
                                                snapshot.data!
                                                    .docs[index]['ticket_price']
                                                    .toString(),
                                                snapshot.data!.docs[index]
                                                    ['flight_id']);
                                          },
                                          child: Text('Book Now'))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                    );
                  }
                  return CircularProgressIndicator();
                });
          },
        ));
  }
}
