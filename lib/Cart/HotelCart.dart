import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palmer/Cart/flightCart.dart';
import 'package:palmer/Cart/transportCart.dart';

class HotelCart extends StatefulWidget {
  const HotelCart({super.key});
  gethotelprice() {
    return price;
  }

  @override
  State<HotelCart> createState() => _HotelCartState();
}

int price = 0;

class _HotelCartState extends State<HotelCart> {
  @override
  Widget build(BuildContext context) {
    TransportCart tcart = TransportCart();
    flightCart fcart = flightCart();
    final user = FirebaseAuth.instance;
    final CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('app')
        .doc('requests')
        .collection('hotel');
    FirebaseFirestore firestore = FirebaseFirestore.instance;
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
                child: Text("No Hotels yet"),
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
                  price = customerhotellist[index]['hotel_price'];

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
                                      margin: EdgeInsets.fromLTRB(10, 10, 0, 5),
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              customerhotellist[index]
                                                  ['hotel_image']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 10, 0, 5),
                                        child: Row(
                                          children: [
                                            Text('HOTEL NAME: ',
                                                style: GoogleFonts
                                                    .yanoneKaffeesatz(
                                                        fontSize: 20)),
                                            SizedBox(width: 5.0),
                                            Text(
                                              customerhotellist[index]
                                                  ['hotel_name'],
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
                                            Text('LOCATION:',
                                                style: GoogleFonts
                                                    .yanoneKaffeesatz(
                                                        fontSize: 20)),
                                            SizedBox(width: 5.0),
                                            Text(
                                              customerhotellist[index]
                                                  ['hotel_location'],
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
                                            Text('Rating:',
                                                style: GoogleFonts
                                                    .yanoneKaffeesatz(
                                                        fontSize: 20)),
                                            SizedBox(width: 5.0),
                                            Text(
                                              customerhotellist[index]
                                                  ['hotel_rating'],
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
                                            Text('STAY:',
                                                style: GoogleFonts
                                                    .yanoneKaffeesatz(
                                                        fontSize: 20)),
                                            SizedBox(width: 5.0),
                                            Text(
                                              '2 nights',
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
                                          'PKR ${customerhotellist[index]['hotel_price'] * 2} /-',
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
                                              .collection('hotel')
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
              'PKR ${fcart.getflightprice() + tcart.gettransportprice() + price}/-',
              style: GoogleFonts.teko(fontSize: 20, color: Colors.grey),
            )
          ],
        ),
      )),
    );
  }
}
