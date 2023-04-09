import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:palmer/Cart/checkoutScreen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser;
    final CollectionReference request = FirebaseFirestore.instance
        .collection('app')
        .doc('Services')
        .collection('requests');
    setState(() {});
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.teal[300]),
        backgroundColor: Colors.white,
        title: Text(
          'CART',
          style: TextStyle(color: Colors.teal),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CardDetails()));
              firestore
                  .collection('app')
                  .doc('Services')
                  .collection('requests')
                  .doc(user?.uid)
                  .update({'status': 'success'});
            },
            child: Container(
              child: Text(
                'Checkout',
                style: GoogleFonts.bangers(
                    color: Colors.teal[300], letterSpacing: 2),
              ),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              padding: EdgeInsets.all(10),
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: request.snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                if (snapshot.data!.docs[index]['customer_id'] == user?.uid &&
                    snapshot.data!.docs[index]['status'] == 'pending') {
                  if (snapshot.data!.docs[index]['hotel_id'] != null &&
                      snapshot.data!.docs[index]['flight_id'] != null &&
                      snapshot.data!.docs[index]['transit_id'] != null) {
                    return SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                            // Container(
                            //     margin: EdgeInsets.symmetric(vertical: 10),
                            //     child: hotelCart(
                            //         snapshot, index, firestore, user)),
                            Container(
                              child: transportCart(
                                  snapshot, index, firestore, user),
                            ),
                            SizedBox(height: 5),
                            Container(
                              child:
                                  FlightCart(snapshot, index, firestore, user),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              child: transportCart(
                                  snapshot, index, firestore, user),
                            ),
                            SizedBox(height: 5),
                            Container(
                              child:
                                  FlightCart(snapshot, index, firestore, user),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                } else {
                  if (snapshot.data!.docs.isEmpty ||
                      snapshot.data!.docs[index]['status'] == 'success') {
                    setState(() {});
                    return Center(
                        child: Container(
                            margin: EdgeInsets.only(top: 130),
                            child: Text('Nothing in Cart')));
                  } else {
                    return Center(
                      child: Container(
                          margin: EdgeInsets.only(top: 130),
                          child: Text('ADD SOMETING IN CART')),
                    );
                  }
                }
              });
        },
      ),
    );
  }
}

// Widget hotelCart(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index,
//     FirebaseFirestore firestore, User? user) {
//   return
// }

Widget transportCart(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index,
    FirebaseFirestore firestore, User? user) {
  return Card(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(colors: [
          Color.fromARGB(200, 255, 194, 101),
          Color.fromARGB(199, 248, 229, 199)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  // transprot type
                  snapshot.data!.docs[index]['transit_type'],
                  style: GoogleFonts.bebasNeue(
                      color: Colors.white, fontSize: 20, letterSpacing: 3),
                )),
            Column(
              children: [
                Row(
                  children: [
                    Text('PICK:'),
                    Text(snapshot.data!.docs[index]['transit_pickup']),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('DROP:'),
                    Text(snapshot.data!.docs[index]['transit_destination']),
                  ],
                ),
              ],
            ),
            Container(
                child: Column(
              children: [
                Text(snapshot.data!.docs[index]['transit_price'].toString() +
                    '/-'),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red[300],
                    ))
              ],
            )),
          ],
        ),
      ),
    ),
  );
}

Widget FlightCart(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index,
    FirebaseFirestore firestore, User? user) {
  return Card(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(colors: [
          Color.fromARGB(200, 255, 194, 101),
          Color.fromARGB(199, 248, 229, 199)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  // transprot type
                  snapshot.data!.docs[index]['airline_name'],
                  style: GoogleFonts.bebasNeue(
                      color: Colors.white, fontSize: 20, letterSpacing: 3),
                )),
            Column(
              children: [
                Row(
                  children: [
                    Text(snapshot.data!.docs[index]['flight_departure']),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(snapshot.data!.docs[index]['flight_destination']),
                  ],
                ),
              ],
            ),
            Container(
                child: Column(
              children: [
                Text(snapshot.data!.docs[index]['flight_price'].toString() +
                    '/-'),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red[300],
                    ))
              ],
            )),
          ],
        ),
      ),
    ),
  );
}
