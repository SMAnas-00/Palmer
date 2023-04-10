import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palmer/AdminControls/addTransport.dart';
import 'package:palmer/Cart/CartScreen.dart';
import 'package:palmer/Services/Transport/TransportDetails.dart';

import '../../Screens/HomeScreen.dart';
import '../../addons/NavBar.dart';
import '../Request.dart';

class TransportService extends StatefulWidget {
  const TransportService({super.key});

  @override
  State<TransportService> createState() => _TransportServiceState();
}

class _TransportServiceState extends State<TransportService> {
  Request request = Request();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference Transportitems = FirebaseFirestore.instance
      .collection('app')
      .doc('Services')
      .collection('Transport');
  late Stream<QuerySnapshot> _streamTransport;

  void initState() {
    super.initState();
    _streamTransport = Transportitems.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final BackArrow = IconButton(
        color: Color.fromARGB(255, 255, 194, 101),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHome()));
        },
        icon: Icon(Icons.arrow_back));
    return Scaffold(
      appBar: AppBar(
        leading: BackArrow,
        actions: [
          GestureDetector(
            child: Container(
                margin: EdgeInsets.only(right: 30),
                padding: EdgeInsets.all(20),
                child: Text(
                  'CHECKOUT',
                  style: TextStyle(color: Colors.teal),
                )),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Cart()));
            },
          )
        ],
        automaticallyImplyLeading: true,
        title: Text(
          'Transport',
          style: TextStyle(color: Color.fromARGB(255, 29, 165, 153)),
        ),
        backgroundColor: Color.fromARGB(255, 254, 253, 252),
      ),
      drawer: NavBar(),
      body: StreamBuilder(
          stream: _streamTransport,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.connectionState == ConnectionState.active) {
              QuerySnapshot querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> listqureysnap = querySnapshot.docs;
              return ListView.builder(
                itemCount: listqureysnap.length,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot document = listqureysnap[index];
                  //final img = document['Hotel_image'].toString();
                  return SingleChildScrollView(
                    child: Container(
                        // margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Card(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                document['Transport_type'],
                                style:
                                    GoogleFonts.racingSansOne(letterSpacing: 3),
                              ),
                            ),
                            Container(
                                child: Text(document['Pick_up'] +
                                    '-' +
                                    document['Destination'])),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    document['Fair'].toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.teal[300],
                                          minimumSize: Size(15, 10)),
                                      onPressed: () {
                                        String type = snapshot.data!.docs[index]
                                            ['Transport_type'];
                                        String destination = snapshot
                                            .data!.docs[index]['Destination'];
                                        String pickup = snapshot
                                            .data!.docs[index]['Pick_up'];
                                        int fareprice =
                                            snapshot.data!.docs[index]['Fair'];
                                        String trans_imgURL = snapshot.data!
                                            .docs[index]['transport_imageURL'];
                                        String transId =
                                            snapshot.data!.docs[index].id;
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TransportDetails(
                                                      transtype: type,
                                                      destination: destination,
                                                      pickup: pickup,
                                                      trans_imgURL:
                                                          trans_imgURL,
                                                      fareprice: fareprice,
                                                      transId: transId,
                                                    )));
                                      },
                                      child: Text('Book Now'))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
