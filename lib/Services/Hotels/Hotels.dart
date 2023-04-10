import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palmer/Screens/HomeScreen.dart';
import 'package:palmer/AdminControls/addHotels.dart';
import 'package:palmer/Services/Hotels/HotelDetails.dart';
import 'package:palmer/Services/Request.dart';
import 'package:palmer/Services/Tickets/Flight.dart';
import 'package:palmer/Services/Transport/Transport.dart';
import 'package:palmer/addons/NavBar.dart';

class Hotels extends StatefulWidget {
  const Hotels({super.key});

  @override
  State<Hotels> createState() => _HotelsState();
}

class _HotelsState extends State<Hotels> {
  Request request = Request();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference Hotelitems = FirebaseFirestore.instance
      .collection('app')
      .doc('Services')
      .collection('Hotels');
  late Stream<QuerySnapshot> _streamHotellistMakkah;

  void initState() {
    super.initState();
    _streamHotellistMakkah = Hotelitems.snapshots();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  bool _isfilter = false;

  @override
  Widget build(BuildContext context) {
    final BackArrow = IconButton(
        color: Color.fromARGB(255, 255, 194, 101),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => FlightScreen()));
        },
        icon: Icon(Icons.arrow_back));
    int dis_filter = 0;
    return Scaffold(
      appBar: AppBar(
        leading: BackArrow,
        actions: [
          GestureDetector(
            child: Container(
                margin: EdgeInsets.only(right: 30),
                padding: EdgeInsets.all(20),
                child: Text(
                  'SKIP',
                  style: TextStyle(color: Colors.teal),
                )),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => TransportService()));
            },
          )
        ],
        automaticallyImplyLeading: true,
        title: Text(
          'Hotels',
          style: TextStyle(color: Color.fromARGB(255, 29, 165, 153)),
        ),
        backgroundColor: Color.fromARGB(255, 254, 253, 252),
        // bottom: TabBar(tabs: [
        //   Tab(child: Text('ALL')),
        //   Tab(child: Text('5KM')),
        // ]),
      ),
      drawer: NavBar(),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: _streamHotellistMakkah,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.connectionState == ConnectionState.active) {
              QuerySnapshot querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> listqureysnap = querySnapshot.docs;

              return Container(
                color: Colors.teal[100],
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.black12),
                              onPressed: () {
                                dis_filter = 5;
                                setState(() {
                                  _isfilter = true;
                                  print(_isfilter);
                                  print(dis_filter);
                                });
                              },
                              child: Text('5KM')),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.black12),
                              onPressed: () {},
                              child: Text('10KM')),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.black12),
                              onPressed: () {},
                              child: Text('Mina'))
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          itemCount: listqureysnap.length,
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot document =
                                listqureysnap[index];
                            final img = document['hotel_imageURL'];

                            for (DocumentSnapshot doc in listqureysnap) {
                              int dist = doc.get('distance');
                              if (dist <= dis_filter) {
                                print('5KM');
                              }
                            }
                            print(_isfilter);
                            if (_isfilter == true) {
                              if (dis_filter <= (document['distance'])) {
                                print('condition run');
                                print(document['distance']);
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Card(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 10.0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                //padding: EdgeInsets.all(40.0),
                                                decoration: BoxDecoration(
                                                    color: Colors.lightGreen),
                                                child: Image.network(
                                                  '$img',
                                                  height: 100.0,
                                                  width: 100.0,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        child: Text(
                                                      document['name'],
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              29,
                                                              165,
                                                              153),
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .location_on_outlined,
                                                          color:
                                                              Colors.grey[600],
                                                          size: 12.0,
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            document[
                                                                'Hotel_location'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[500],
                                                                fontSize: 13.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.hotel_class,
                                                          color: Color.fromARGB(
                                                              200,
                                                              255,
                                                              194,
                                                              101),
                                                          size: 17.0,
                                                        ),
                                                        Container(
                                                            child: Text(
                                                          document['Stars']
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[600],
                                                              fontSize: 13.0),
                                                        )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "₨" +
                                                            document[
                                                                    'Hotel_price']
                                                                .toString() +
                                                            "/-",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15.0),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          String name = snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ['name'];
                                                          String location = snapshot
                                                                  .data!
                                                                  .docs[index][
                                                              'Hotel_location'];
                                                          String rating =
                                                              snapshot.data!
                                                                          .docs[
                                                                      index]
                                                                  ['Stars'];
                                                          String capacity =
                                                              snapshot.data!
                                                                          .docs[
                                                                      index][
                                                                  'Room_capacity'];
                                                          int HotelPrice =
                                                              snapshot.data!
                                                                          .docs[
                                                                      index][
                                                                  'Hotel_price'];
                                                          String hotel_imgURL =
                                                              snapshot.data!
                                                                          .docs[
                                                                      index][
                                                                  'hotel_imageURL'];
                                                          String hotelId =
                                                              snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id;

                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => HotelsDetails(
                                                                      hotelName:
                                                                          name,
                                                                      hotelLocation:
                                                                          location,
                                                                      hotelRating:
                                                                          rating,
                                                                      hotelImageURL:
                                                                          hotel_imgURL,
                                                                      hotelcapacity:
                                                                          capacity,
                                                                      hotelPrice:
                                                                          HotelPrice,
                                                                      hotelid:
                                                                          hotelId)));
                                                          // final reqId =
                                                          //     '${auth.currentUser!.uid}';
                                                          // request.Hotelreq(
                                                          //     reqId,
                                                          //     document['name'],
                                                          //     document['Hotel_id'],
                                                          //     document['Hotel_price'],
                                                          //     document['Hotel_image']);
                                                        },
                                                        child: Text("Book Now"),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Color.fromARGB(
                                                                        255,
                                                                        29,
                                                                        165,
                                                                        153),
                                                                minimumSize:
                                                                    Size(15,
                                                                        10)),
                                                      )
                                                    ]),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            } else {
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Card(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 10.0),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              //padding: EdgeInsets.all(40.0),
                                              decoration: BoxDecoration(
                                                  color: Colors.lightGreen),
                                              child: Image.network(
                                                '$img',
                                                height: 100.0,
                                                width: 100.0,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      child: Text(
                                                    document['name'],
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 29, 165, 153),
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        color: Colors.grey[600],
                                                        size: 12.0,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          document[
                                                              'Hotel_location'],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[500],
                                                              fontSize: 13.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.hotel_class,
                                                        color: Color.fromARGB(
                                                            200, 255, 194, 101),
                                                        size: 17.0,
                                                      ),
                                                      Container(
                                                          child: Text(
                                                        document['Stars']
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontSize: 13.0),
                                                      )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "₨" +
                                                          document[
                                                                  'Hotel_price']
                                                              .toString() +
                                                          "/-",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15.0),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        String name = snapshot
                                                                .data!
                                                                .docs[index]
                                                            ['name'];
                                                        String location = snapshot
                                                                .data!
                                                                .docs[index]
                                                            ['Hotel_location'];
                                                        String rating = snapshot
                                                                .data!
                                                                .docs[index]
                                                            ['Stars'];
                                                        String capacity =
                                                            snapshot.data!
                                                                    .docs[index]
                                                                [
                                                                'Room_capacity'];
                                                        int HotelPrice =
                                                            snapshot.data!
                                                                    .docs[index]
                                                                ['Hotel_price'];
                                                        String hotel_imgURL =
                                                            snapshot.data!
                                                                    .docs[index]
                                                                [
                                                                'hotel_imageURL'];
                                                        String hotelId =
                                                            snapshot.data!
                                                                .docs[index].id;

                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => HotelsDetails(
                                                                    hotelName:
                                                                        name,
                                                                    hotelLocation:
                                                                        location,
                                                                    hotelRating:
                                                                        rating,
                                                                    hotelImageURL:
                                                                        hotel_imgURL,
                                                                    hotelcapacity:
                                                                        capacity,
                                                                    hotelPrice:
                                                                        HotelPrice,
                                                                    hotelid:
                                                                        hotelId)));
                                                        // final reqId =
                                                        //     '${auth.currentUser!.uid}';
                                                        // request.Hotelreq(
                                                        //     reqId,
                                                        //     document['name'],
                                                        //     document['Hotel_id'],
                                                        //     document['Hotel_price'],
                                                        //     document['Hotel_image']);
                                                      },
                                                      child: Text("Book Now"),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          29,
                                                                          165,
                                                                          153),
                                                              minimumSize:
                                                                  Size(15, 10)),
                                                    )
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              ;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
