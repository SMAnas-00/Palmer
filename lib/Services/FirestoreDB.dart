import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDB {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  DBusers() async {
    QuerySnapshot dbusers = await _firebaseFirestore
        .collection('app')
        .doc('Users')
        .collection('Signup')
        .get();
  }

  DBHotels() {
    final dbhotels = _firebaseFirestore
        .collection('app')
        .doc('Services')
        .collection('Hotels')
        .snapshots();
  }

  DBTransport() {
    final dbtransport = _firebaseFirestore
        .collection('app')
        .doc('Services')
        .collection('Transport')
        .snapshots();
  }
}
