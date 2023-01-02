import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:palmer/Cart/models/Product_model.dart';

class FirestoreDB {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Stream<List<Product>> getallProduct() {
  //   return _firebaseFirestore
  //       .collection('app')
  //       .doc('Services')
  //       .collection('Hotels')
  //       .snapshots()
  //       .map((snapshots) {
  //     return snapshots.docs.map((doc) => Product.fromSnapshot(doc)).toList();
  //   });
  // }
}
