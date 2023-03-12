import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Request {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Hotelreq(String adminId, cusId, hotelname, hotelid, hotelprice, hotelimg) {
    firestore
        .collection('app')
        .doc('Services')
        .collection('requests')
        .doc('${cusId}${DateTime.now().millisecondsSinceEpoch}')
        .set({
      'customer_id': cusId,
      'hotel_name': hotelname,
      'hotel_id': hotelid,
      'hotel_price': hotelprice,
      'hotel_image': hotelimg,
      'adminId': adminId,
      'status': 'Pending'
    });
  }

  Transreq(String adminId, cusId, transittype, transitid, transitprice,
      transitpick, transitdrop) {
    firestore
        .collection('app')
        .doc('Services')
        .collection('requests')
        .doc('${cusId}${DateTime.now().millisecondsSinceEpoch}')
        .update({
      'customer_id': cusId,
      'transit_type': transittype,
      'transit_id': transitid,
      'tansit_price': transitprice,
      'transit_pick': transitpick,
      'transit_drop': transitdrop,
      'adminId': adminId,
      'status': 'pending'
    });
  }

  Ticketreq(String cusId, adminId, flightname, departure, destination,
      ticketprice, flightid) async {
    await firestore
        .collection('app')
        .doc('Services')
        .collection('requests')
        .doc('$cusId${DateTime.now()}')
        .update({
      'adminId': adminId,
      'customer_id': cusId,
      'airline_name': flightname,
      'flight_id': flightid,
      'flight_price': ticketprice,
      'flight_departure': departure,
      'flight_destination': destination,
      'status': 'pending'
    });
  }
}
