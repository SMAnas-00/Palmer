import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:palmer/Services/Transport/addTransport.dart';

import '../../HomeScreen.dart';
import '../../addons/NavBar.dart';

class TransportService extends StatefulWidget {
  const TransportService({super.key});

  @override
  State<TransportService> createState() => _TransportServiceState();
}

class _TransportServiceState extends State<TransportService> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference Transportitems = FirebaseFirestore.instance
      .collection('app')
      .doc('Services')
      .collection('Transport');
  late Stream<QuerySnapshot> _streamTransport;

  void initState() {
    super.initState();
    _streamTransport = Transportitems.snapshots();
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
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => addTransportScreen()));
            },
          )
        ],
        backgroundColor: Color.fromARGB(255, 254, 253, 252),
      ),
      drawer: NavBar(),
      body: StreamBuilder(
          stream: _streamTransport,
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
                  //final img = document['Hotel_image'].toString();
                  return Container(child: Card());
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
