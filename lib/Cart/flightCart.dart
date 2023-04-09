import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palmer/Cart/HotelCart.dart';
import 'package:palmer/Cart/transportCart.dart';

class flightCart extends StatefulWidget {
  const flightCart({super.key});
  getflightprice() {
    return price;
  }

  @override
  State<flightCart> createState() => _flightCartState();
}

int price = 0;

class _flightCartState extends State<flightCart> {
  @override
  Widget build(BuildContext context) {
    HotelCart hcart = HotelCart();
    TransportCart tcart = TransportCart();
    final user = FirebaseAuth.instance;
    final CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('app')
        .doc('requests')
        .collection('flight');
    return Scaffold(
      body: StreamBuilder(
          stream: collectionReference.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text("Loading..."));
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No flight Yet"),
              );
            }
            final customerhotellist = snapshot.data!.docs.where((doc) {
              final custmId = doc['customer_id'];
              return user.currentUser!.uid == custmId;
            }).toList();
            if (customerhotellist.isEmpty) {
              return Center(
                child: Text('Flight not Booked'),
              );
            }
            return ListView.builder(
                itemCount: customerhotellist.length,
                itemBuilder: (context, index) {
                  price = customerhotellist[index]['flight_price'];
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Container(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 20.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Text(
                                          'BILL',
                                          style: GoogleFonts.righteous(),
                                        )),
                                    SizedBox(height: 10),
                                    Divider(thickness: 4),
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 10, 0, 5),
                                        child: Row(
                                          children: [
                                            Text('AIRLINE: ',
                                                style: GoogleFonts
                                                    .yanoneKaffeesatz(
                                                        fontSize: 20)),
                                            SizedBox(width: 5.0),
                                            Text(
                                              customerhotellist[index]
                                                  ['airline_name'],
                                              style: GoogleFonts.teko(
                                                  fontSize: 20,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 10, 0, 5),
                                        child: Row(
                                          children: [
                                            Text('FROM:',
                                                style: GoogleFonts
                                                    .yanoneKaffeesatz(
                                                        fontSize: 20)),
                                            SizedBox(width: 5),
                                            Text(
                                              customerhotellist[index]
                                                  ['flight_departure'],
                                              style: GoogleFonts.teko(
                                                  fontSize: 20,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 10, 0, 5),
                                        child: Row(
                                          children: [
                                            Text('To:',
                                                style: GoogleFonts
                                                    .yanoneKaffeesatz(
                                                        fontSize: 20)),
                                            SizedBox(width: 5),
                                            Text(
                                              customerhotellist[index]
                                                  ['flight_destination'],
                                              style: GoogleFonts.teko(
                                                  fontSize: 20,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 10, 0, 5),
                                        child: Row(
                                          children: [
                                            Text('WITH RETURN:',
                                                style: GoogleFonts
                                                    .yanoneKaffeesatz(
                                                        fontSize: 20)),
                                            SizedBox(width: 5),
                                            Text(
                                              'NO',
                                              style: GoogleFonts.teko(
                                                  fontSize: 20,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 10, 0, 5),
                                        child: Row(
                                          children: [
                                            Text('DATE:',
                                                style: GoogleFonts
                                                    .yanoneKaffeesatz(
                                                        fontSize: 20)),
                                            SizedBox(width: 5),
                                            Text(
                                              '6/4/2023',
                                              style: GoogleFonts.teko(
                                                  fontSize: 20,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 10, 0, 5),
                                        child: Row(
                                          children: [
                                            Text('TIME:',
                                                style: GoogleFonts
                                                    .yanoneKaffeesatz(
                                                        fontSize: 20)),
                                            SizedBox(width: 5),
                                            Text(
                                              '18:30',
                                              style: GoogleFonts.teko(
                                                  fontSize: 20,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        )),
                                    SizedBox(height: 30),
                                    Divider(thickness: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Price:',
                                          style: GoogleFonts.yanoneKaffeesatz(
                                              fontSize: 20),
                                        ),
                                        Text(
                                          'PKR ${customerhotellist[index]['flight_price']} /-',
                                          style: GoogleFonts.teko(
                                              fontSize: 20, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Container(
                                      child: IconButton(
                                        onPressed: () {
                                          final firestore = FirebaseFirestore
                                              .instance
                                              .collection('app')
                                              .doc('requests')
                                              .collection('flight')
                                              .doc(user.currentUser!.uid)
                                              .delete()
                                              .then((value) {
                                            collectionReference
                                                .doc(user.currentUser!.uid)
                                                .update({
                                              '${user.currentUser!.uid}':
                                                  FieldValue.delete()
                                            });
                                            setState(() {
                                              price = 0;
                                            });
                                          });
                                        },
                                        icon: Icon(Icons.delete),
                                        color: Colors.red,
                                        iconSize: 40,
                                      ),
                                    )
                                  ],
                                ),
                              ))),
                    ),
                  );
                });
          }),
      bottomNavigationBar: BottomAppBar(
          child: Padding(
        padding: EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'TOTAL',
              style: GoogleFonts.yanoneKaffeesatz(fontSize: 20),
            ),
            Text(
              'PKR ${hcart.gethotelprice() + tcart.gettransportprice() + price}/-',
              style: GoogleFonts.teko(fontSize: 20, color: Colors.grey),
            )
          ],
        ),
      )),
    );
  }
}
