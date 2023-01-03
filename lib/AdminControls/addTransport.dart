import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:palmer/AdminControls/AdminDash.dart';

import '../main.dart';

class addTransportScreen extends StatefulWidget {
  const addTransportScreen({super.key});

  @override
  State<addTransportScreen> createState() => _addTransportScreenState();
}

class _addTransportScreenState extends State<addTransportScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final _WhereTo = TextEditingController();
  final _WhereFrom = TextEditingController();
  final _Fairforthetrip = TextEditingController();
  final _Transtype = TextEditingController();

  addTransport() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      print("Form is vaid ");

      print('Data for login ');

      var did = DateTime.now().microsecondsSinceEpoch;

      try {
        await firestore
            .collection('app')
            .doc('Services')
            .collection('Transport')
            .doc('$did')
            .set({
          'Pick_up': _WhereFrom.text,
          'Destination': _WhereTo.text,
          'Fair': int.parse(_Fairforthetrip.text),
          'Transport_type': _Transtype.text,
          'Trans_id': did.toString()
        });
      } on FirebaseException catch (e) {
        displayMessage(e.toString());
      }
    }
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
                  controller: _WhereTo,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Destination',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Destination Required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _WhereFrom,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Pick Up'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Destination Required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _Fairforthetrip,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Fair for the trip'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fair Required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _Transtype,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Type of Transit'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
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
                  onPressed: addTransport,
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
