import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:palmer/Services/Hotels/Hotels.dart';
import 'package:palmer/Services/Transport/Transport.dart';

import '../../main.dart';

class HotelsDetails extends StatefulWidget {
  String hotelName;
  String hotelLocation;
  String hotelRating;
  String hotelImageURL;
  int hotelPrice;
  String hotelcapacity;
  String hotelid;

  HotelsDetails(
      {super.key,
      required this.hotelName,
      required this.hotelLocation,
      required this.hotelRating,
      required this.hotelImageURL,
      required this.hotelcapacity,
      required this.hotelPrice,
      required this.hotelid});

  @override
  State<HotelsDetails> createState() => _HotelsDetailsState();
}

class _HotelsDetailsState extends State<HotelsDetails> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth user = FirebaseAuth.instance;
  DateTime _selectedCheckInDate = DateTime.now();
  late DateTime _selectedCheckOutDate = DateTime.now();
  int _selectedNumberOfGuests = 1;

  Future<void> _selectDate(BuildContext context, bool isCheckInDate) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: isCheckInDate ? DateTime.now() : _selectedCheckOutDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365 * 10)));
    if (picked != null && picked != _selectedCheckInDate) {
      setState(() {
        if (isCheckInDate) {
          _selectedCheckInDate = picked;
        } else {
          _selectedCheckOutDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final BackArrow = IconButton(
        color: Color.fromARGB(255, 255, 194, 101),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Hotels()));
        },
        icon: Icon(Icons.arrow_back));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4BA0FE),
        title: const Text("Hotel Detail"),
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
                    child: widget.hotelImageURL != ""
                        ? Image.network(
                            widget.hotelImageURL,
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
                        widget.hotelName,
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
                  Icons.location_city,
                  color: Colors.green,
                  size: 10.0,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text('LOCATION : ${widget.hotelLocation}'),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.red,
                  size: 10.0,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text('RATING : ${widget.hotelRating}'),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Check-in',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    InkWell(
                      onTap: () => _selectDate(context, true),
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: _selectedCheckInDate == null
                              ? 'Select date'
                              : '${_selectedCheckInDate.day}/${_selectedCheckInDate.month}/${_selectedCheckInDate.year}',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                  ],
                )),
                SizedBox(width: 16.0),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Check-out',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    InkWell(
                      onTap: () => _selectDate(context, false),
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: _selectedCheckOutDate == null
                              ? 'Select date'
                              : '${_selectedCheckOutDate.day}/${_selectedCheckOutDate.month}/${_selectedCheckOutDate.year}',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),

          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Number of Rooms',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton<int>(
                value: _selectedNumberOfGuests,
                items: List.generate(4, (index) {
                  return DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text('${index + 1}'),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    _selectedNumberOfGuests = value!;
                  });
                },
              )
            ],
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
                Text('ROOM PRICE : ${widget.hotelPrice}/night'),
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
                      .collection('hotel')
                      .doc('${user.currentUser!.uid}')
                      .set({
                        'hotel_name': widget.hotelName,
                        'hotel_image': widget.hotelImageURL,
                        'hotel_id': widget.hotelid,
                        'customer_id': user.currentUser!.uid,
                        'hotel_price': widget.hotelPrice,
                        'hotel_location': widget.hotelLocation,
                        'hotel_rating': widget.hotelRating,
                        'hotel_capacity': widget.hotelcapacity,
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransportService()));
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
