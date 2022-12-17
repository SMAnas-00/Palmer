import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Hotels extends StatefulWidget {
  const Hotels({super.key});

  @override
  State<Hotels> createState() => _HotelsState();
}

class _HotelsState extends State<Hotels> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference Hotelitems = FirebaseFirestore.instance
      .collection('app')
      .doc('Hotels')
      .collection('Makkah');
  late Stream<QuerySnapshot> _streamHotellistMakkah;

  void initState() {
    super.initState();
    _streamHotellistMakkah = Hotelitems.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                return Column(
                  children: [
                    Text(document['Hotel_name']),
                    Text(document['Stars'].toString()),
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
