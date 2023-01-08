import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Request {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Hotelreq(String reqid, hotelname, hotelid, hotelprice, hotelimg) {
    firestore
        .collection('app')
        .doc('Services')
        .collection('requests')
        .doc('${reqid}' + '${DateTime.now().millisecondsSinceEpoch}')
        .set({
      'customer_id': reqid,
      'hotel_name': hotelname,
      'hotel_id': hotelid,
      'hotel_price': hotelprice,
      'hotel_image': hotelimg,
      'status': 'Pending'
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
      'status': 'pending'
    });
  }

  Ticketreq(
      String reqId, flightname, departure, destination, ticketprice, flightid) {
    firestore
        .collection('app')
        .doc('Services')
        .collection('requests')
        .doc(reqId)
        .update({
      'customer_id': reqId,
      'airline_name': flightname,
      'flight_id': flightid,
      'flight_price': ticketprice,
      'flight_departure': departure,
      'flight_destination': destination,
      'status': 'pending'
    });
  }
}
