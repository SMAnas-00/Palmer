import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartController {
  final user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;
  CartCheck() async {
    final dbcart = await FirebaseFirestore.instance
        .collection('app')
        .doc('Services')
        .collection('requests')
        .doc(user?.uid)
        .get();
    if (dbcart.data()?['customer_id'] == user?.uid) {}
  }
}
