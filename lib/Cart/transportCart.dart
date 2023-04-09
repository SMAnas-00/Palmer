import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palmer/Cart/HotelCart.dart';
import 'package:palmer/Cart/flightCart.dart';

class TransportCart extends StatefulWidget {
  const TransportCart({super.key});
  gettransportprice() {
    return price;
  }

  @override
  State<TransportCart> createState() => _TransportCartState();
}

int price = 0;

class _TransportCartState extends State<TransportCart> {
  @override
  Widget build(BuildContext context) {
    HotelCart hcart = HotelCart();
    flightCart fcart = flightCart();
    final user = FirebaseAuth.instance;
    final CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('app')
        .doc('requests')
        .collection('transport');
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
                child: Text("No Transport yet"),
              );
            }
            final customerhotellist = snapshot.data!.docs.where((doc) {
              final custmId = doc['customer_id'];
              return user.currentUser!.uid == custmId;
            }).toList();
            if (customerhotellist.isEmpty) {
              return Center(
                child: Text('Noting'),
              );
            }
            return ListView.builder(
                itemCount: customerhotellist.length,
                itemBuilder: (context, index) {
                  price = customerhotellist[index]['transit_price'];
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
                                            Text('VEHICLE ID:',
                                                style: GoogleFonts
                                                    .yanoneKaffeesatz(
                                                        fontSize: 20)),
                                            SizedBox(width: 5.0),
                                            Text(
                                              customerhotellist[index]
                                                  ['transit_id'],
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
                                            Text('VEHICLE NAME:',
                                                style: GoogleFonts
                                                    .yanoneKaffeesatz(
                                                        fontSize: 20)),
                                            SizedBox(width: 5),
                                            Text(
                                              customerhotellist[index]
                                                  ['transit_type'],
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
                                            Text('PICKUP:',
                                                style: GoogleFonts
                                                    .yanoneKaffeesatz(
                                                        fontSize: 20)),
                                            SizedBox(width: 5),
                                            Text(
                                              customerhotellist[index]
                                                  ['transit_pickup'],
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
                                            Text('DESTINATION:',
                                                style: GoogleFonts
                                                    .yanoneKaffeesatz(
                                                        fontSize: 20)),
                                            SizedBox(width: 5),
                                            Text(
                                              customerhotellist[index]
                                                  ['transit_destination'],
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
                                              '5/4/2023',
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
                                          'PKR ${customerhotellist[index]['transit_price']} /-',
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
                                              .collection('transport')
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
                'PKR ${hcart.gethotelprice() + fcart.getflightprice() + price}/-',
                style: GoogleFonts.teko(fontSize: 20, color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
