import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palmer/HomeScreen.dart';
import 'package:palmer/Services/Hotels/addHotels.dart';
import 'package:palmer/addons/NavBar.dart';

class Hotels extends StatefulWidget {
  const Hotels({super.key});

  @override
  State<Hotels> createState() => _HotelsState();
}

class _HotelsState extends State<Hotels> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference Hotelitems = FirebaseFirestore.instance
      .collection('app')
      .doc('Services')
      .collection('Transport');
  late Stream<QuerySnapshot> _streamHotellistMakkah;

  void initState() {
    super.initState();
    _streamHotellistMakkah = Hotelitems.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final BackArrow = IconButton(
        color: Color.fromARGB(255, 255, 194, 101),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        },
        icon: Icon(Icons.arrow_back));
    return Scaffold(
      appBar: AppBar(
        leading: BackArrow,
        automaticallyImplyLeading: true,
        title: Text(
          'Transport',
          style: TextStyle(color: Color.fromARGB(255, 29, 165, 153)),
        ),
        actions: [
          GestureDetector(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child:
                    Icon(Icons.add, color: Color.fromARGB(255, 255, 194, 101))),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => addHotelScreen()));
            },
          )
        ],
        backgroundColor: Color.fromARGB(255, 254, 253, 252),
      ),
      drawer: NavBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: _streamHotellistMakkah,
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
                // final img = document['Hotel_image'].toString();
                return Column(
                  children: [
                    Card(
                      margin: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10.0),
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 10.0),
                          child: Text(document['Transport_type'])),
                    ),
                  ],
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
