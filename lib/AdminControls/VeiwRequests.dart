import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:palmer/AdminControls/AdminDash.dart';

class VeiwRequestScreen extends StatefulWidget {
  const VeiwRequestScreen({super.key});

  @override
  State<VeiwRequestScreen> createState() => _VeiwRequestScreenState();
}

class _VeiwRequestScreenState extends State<VeiwRequestScreen> {
  FirebaseAuth user = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final CollectionReference allrequest = FirebaseFirestore.instance
        .collection('app')
        .doc('Services')
        .collection('requests');
    var id = allrequest.id;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'REQUESTS',
            style: TextStyle(color: Colors.teal[300]),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.swipe_left_alt_sharp,
              color: Colors.teal[300],
            ),
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => AdminPanel())),
          ),
        ),
        body: StreamBuilder(
          stream: allrequest.snapshots(),
          builder: (context, snapshots) {
            return ListView.builder(
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index) {
                if (snapshots.data!.docs[index]['status'] == 'success') {
                  return Container(
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: Card(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  snapshots.data!.docs[index]['customer_id'],
                                  style: TextStyle(
                                      color: Colors.amber[600],
                                      fontWeight: FontWeight.w500),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text('HOTEL'),
                                    Text(snapshots.data!.docs[index]
                                        ['hotel_name']),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('TRANSPORT'),
                                    Text(snapshots.data!.docs[index]
                                        ['transit_type']),
                                  ],
                                ),
                                Column(
                                  children: [Text('FLIGHT')],
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.assignment_turned_in_rounded,
                                      color: Colors.green[300],
                                    ),
                                    onPressed: () {},
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return CircularProgressIndicator();
              },
            );
          },
        ));
  }
}
