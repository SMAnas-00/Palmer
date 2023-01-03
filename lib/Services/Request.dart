import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Request {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Hotelreq(String reqid, hotelname, hotelid, hotelprice) {
    firestore
        .collection('app')
        .doc('Services')
        .collection('requests')
        .doc(reqid)
        .set({
      'customer_id': reqid,
      'hotel_name': hotelname,
      'hotel_id': hotelid,
      'hotel_price': hotelprice,
    });
  }

  Transreq(String reqid, transittype, transitid, transitprice, transitpick,
      transitdrop) {
    firestore
        .collection('app')
        .doc('Services')
        .collection('requests')
        .doc(reqid)
        .update({
      'customer_id': reqid,
      'transit_type': transittype,
      'transit_id': transitid,
      'tansit_price': transitprice,
      'transit_pick': transitpick,
      'transit_drop': transitdrop,
    });
  }

  Ticketreq() {}
}
