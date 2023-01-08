import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:palmer/AdminControls/AdminDash.dart';

import '../main.dart';

class addFlightScreen extends StatefulWidget {
  const addFlightScreen({super.key});

  @override
  State<addFlightScreen> createState() => _addFlightScreenState();
}

class _addFlightScreenState extends State<addFlightScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final _departure = TextEditingController();
  final _destination = TextEditingController();
  final _flightprice = TextEditingController();
  final _flightid = TextEditingController();
  final _flightname = TextEditingController();

  addFlight() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      print("Form is vaid ");

      print('Data for login ');

      var did = DateTime.now().millisecondsSinceEpoch;

      try {
        await firestore
            .collection('app')
            .doc('Services')
            .collection('Flight')
            .doc('$did')
            .set({
          'airline_name': _flightname.text,
          'departure': _departure.text,
          'destination': _destination.text,
          'ticket_price': int.parse(_flightprice.text),
          'flight_id': did.toString()
        });
      } on FirebaseException catch (e) {
        displayMessage(e.toString());
      }
    }
    _departure.clear();
    _destination.clear();
    _flightname.clear();
    _flightprice.clear();
  }

  @override
  Widget build(BuildContext context) {
    final BackArrow = IconButton(
        color: Color.fromARGB(255, 255, 194, 101),
        onPressed: () {
          //Navigator.pop(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AdminPanel()));
        },
        icon: Icon(Icons.arrow_back));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackArrow,
        centerTitle: true,
        title: Text('Book Your Transport',
            style: TextStyle(color: Color.fromARGB(255, 29, 165, 153))),
        backgroundColor: Colors.white,
      ),
      body: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _flightname,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'AIRLINE NAME',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name Required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _departure,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'DEPARTURE'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Departure Required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _destination,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'DESTINATION'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'DESTINATION Required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _flightprice,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'FLIGHT PRICE'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'FLIGHT PRICE Required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 12.0,
                      backgroundColor: Color.fromARGB(255, 29, 165, 153)),
                  onPressed: addFlight,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
