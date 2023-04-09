import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:palmer/Screens/tripScreen.dart';
import 'package:palmer/Services/Hotels/Hotels.dart';
import 'package:palmer/Services/Request.dart';
import 'package:palmer/Services/Tickets/Flight.dart';
import 'package:palmer/main.dart';

class FlightDetails extends StatefulWidget {
  String airline_name;
  String departure;
  String destination;
  String flight_id;
  int flightPrice;
  String admin_id;
  String flight_imageURL;
  FlightDetails({
    super.key,
    required this.airline_name,
    required this.departure,
    required this.destination,
    required this.flight_id,
    required this.flightPrice,
    required this.admin_id,
    required this.flight_imageURL,
  });

  @override
  State<FlightDetails> createState() => _FlightDetailsState();
}

class _FlightDetailsState extends State<FlightDetails> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth user = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final BackArrow = IconButton(
        color: Color.fromARGB(255, 255, 194, 101),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => FlightScreen()));
        },
        icon: Icon(Icons.arrow_back));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4BA0FE),
        title: const Text("Flight Detail"),
        leading: BackArrow,
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
                    child: widget.flight_imageURL != ""
                        ? Image.network(
                            widget.flight_imageURL,
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
                        widget.airline_name,
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
                Text('DEPARTURE : ${widget.departure}'),
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
                Text('Estimated fare : ${widget.flightPrice}/seat'),
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
                      .collection('flight')
                      .doc('${user.currentUser!.uid}')
                      .set({
                        'adminId': widget.admin_id,
                        'customer_id': user.currentUser!.uid,
                        'airline_name': widget.airline_name,
                        'flight_id': widget.flight_id,
                        'flight_price': widget.flightPrice,
                        'flight_departure': widget.departure,
                        'flight_destination': widget.destination,
                        'status': 'pending'
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
                      MaterialPageRoute(builder: (context) => Hotels()));
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
