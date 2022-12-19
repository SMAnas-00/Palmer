import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palmer/Services/Hotels/Hotels.dart';
import 'package:palmer/main.dart';

class addHotelScreen extends StatefulWidget {
  const addHotelScreen({super.key});

  @override
  State<addHotelScreen> createState() => _addHotelScreenState();
}

class _addHotelScreenState extends State<addHotelScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // var doc_ref = FirebaseFirestore.instance
  //     .collection('app')
  //     .doc('Services')
  //     .collection('Hotels')
  //     .doc();

  //File? _image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final _Hotelname = TextEditingController();
  final _Hotelprice = TextEditingController();
  final _Hotellocation = TextEditingController();
  final _Hotelroom = TextEditingController();
  final _Hotelperson = TextEditingController();
  final _Hoteltype = TextEditingController();
  final _Hotelcity = TextEditingController();
  final _Hotelimage = TextEditingController();

  addHotel() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      print("Form is vaid ");

      print('Data for login ');

      var did = DateTime.now().millisecondsSinceEpoch;

      try {
        await firestore
            .collection('app')
            .doc('Services')
            .collection('Hotels')
            .doc('$did')
            .set({
          'Hotel_name': _Hotelname.text,
          'Hotel_price': _Hotelprice.text,
          'Hotel_location': _Hotellocation.text,
          'Hotel_rooms': _Hotelroom.text,
          'Hotel_city': _Hotelcity.text,
          'Hotel_image': _Hotelimage.text,
          'Active_rooms': '3',
          'Stars': _Hoteltype.text,
          'Room_capacity': _Hotelperson.text,
          'Hotel_id': did.toString(),
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
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Hotels()));
        },
        icon: Icon(Icons.arrow_back));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackArrow,
        centerTitle: true,
        title: Text('Add New Hotel',
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
                SizedBox(height: 20),

                // Hotel Name Feild
                TextFormField(
                  controller: _Hotelname,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Hotel Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hotel Name Required';
                    }
                    return null;
                  },
                ),
                // Hotel Price Feild
                TextFormField(
                  controller: _Hotelprice,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Hotel Price'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hotel Price Required';
                    }
                    return null;
                  },
                ),
                // Hotel Location Feild
                TextFormField(
                  controller: _Hotellocation,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(labelText: 'Hotel Location'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Location  Required';
                    }
                    return null;
                  },
                ),
                // Hotel Type Feild
                TextFormField(
                  controller: _Hoteltype,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Hotel Type ex 5 high - 1 low'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hotel Type  Required';
                    }
                    return null;
                  },
                ),
                // Hotel ROoms
                TextFormField(
                  controller: _Hotelroom,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Rooms'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hotel Type  Required';
                    }
                    return null;
                  },
                ),
                // Person per room
                TextFormField(
                  controller: _Hotelperson,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Persons per Room'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                // Hotel City
                TextFormField(
                  controller: _Hotelcity,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'City'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hotel City  Required';
                    }
                    return null;
                  },
                ),
                // Image Link
                TextFormField(
                  controller: _Hotelimage,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(labelText: 'Image Link'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hotel image link  Required';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 30),

                SizedBox(height: 30),
                // Submit Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 12.0,
                      backgroundColor: Color.fromARGB(255, 29, 165, 153)),
                  onPressed: () {
                    addHotel();
                  },
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
