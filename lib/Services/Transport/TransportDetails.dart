import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:palmer/Cart/checkoutScreen.dart';
import 'package:palmer/Services/Transport/Transport.dart';

import '../../main.dart';

class TransportDetails extends StatefulWidget {
  String transtype;
  String destination;
  String pickup;
  String trans_imgURL;
  int fareprice;
  String transId;
  TransportDetails(
      {super.key,
      required this.transtype,
      required this.destination,
      required this.pickup,
      required this.trans_imgURL,
      required this.fareprice,
      required this.transId});

  @override
  State<TransportDetails> createState() => _TransportDetailsState();
}

class _TransportDetailsState extends State<TransportDetails> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth user = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final BackArrow = IconButton(
        color: Color.fromARGB(255, 255, 194, 101),
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => TransportService()));
        },
        icon: Icon(Icons.arrow_back));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4BA0FE),
        title: const Text("Transport Detail"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  ClipOval(
                    child: widget.trans_imgURL != ""
                        ? Image.network(
                            widget.trans_imgURL,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 60,
                            height: 60,
                            decoration:
                                const BoxDecoration(color: Color(0xff4BA0FE)),
                            child: const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.transtype,
                        style: const TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                const Icon(
                  Icons.circle,
                  color: Colors.green,
                  size: 10.0,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text('PICK-UP : ${widget.pickup}'),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                const Icon(
                  Icons.circle,
                  color: Colors.red,
                  size: 10.0,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text('Destination : ${widget.destination}'),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          const SizedBox(
            height: 10,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20),
          //   child: Row(
          //     children: [
          //       const Icon(
          //         Icons.date_range,
          //         size: 20,
          //         color: Color(0xff4BA0FE),
          //       ),
          //       const SizedBox(
          //         width: 10,
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           const Text('Date'),
          //           Text('${widget.date}'),
          //         ],
          //       )
          //     ],
          //   ),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20),
          //   child: Row(
          //     children: [
          //       const Icon(
          //         Icons.access_time,
          //         size: 20,
          //         color: Color(0xff4BA0FE),
          //       ),
          //       const SizedBox(
          //         width: 10,
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           const Text('Time'),
          //           Text('${widget.time}'),
          //         ],
          //       )
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Estimated fare : ${widget.fareprice}'),
              ],
            ),
          ),
          SizedBox(height: 100),

          Container(
            height: 60,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xff4BA0FE),
            ),
            child: OutlinedButton(
                onPressed: () async {
                  String did = DateTime.now().toString();
                  await firestore
                      .collection('app')
                      .doc('requests')
                      .collection('transport')
                      .doc('${user.currentUser!.uid}')
                      .set({
                        'transit_type': widget.transtype,
                        'customer_id': user.currentUser!.uid,
                        'transit_id': widget.transId,
                        'transit_price': widget.fareprice,
                        'transit_pickup': widget.pickup,
                        'transit_destination': widget.destination,
                      })
                      .then((value) => displayMessage("request has been sent"))
                      .onError((error, stackTrace) =>
                          displayMessage(error.toString()));
                  // request.Ticketreq(
                  //     user.currentUser!.uid,
                  //     widget.admin_id,
                  //     widget.airline_name,
                  //     widget.departure,
                  //     widget.destination,
                  //     widget.flightPrice,
                  //     widget.flight_id);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CardDetails()));
                },
                child: const Text(
                  "BOOK NOW",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
          )
        ],
      ),
    );
  }
}
