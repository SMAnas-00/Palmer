import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palmer/AdminControls/AdminDash.dart';
import 'package:palmer/Services/Hotels/Hotels.dart';
import 'package:palmer/main.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class addHotelScreen extends StatefulWidget {
  const addHotelScreen({super.key});

  @override
  State<addHotelScreen> createState() => _addHotelScreenState();
}

class _addHotelScreenState extends State<addHotelScreen> {
  File? image;
  final picker = ImagePicker();
  String imageUrl = '';

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final _Hotelname = TextEditingController();
  final _Hotelprice = TextEditingController();
  final _Hotellocation = TextEditingController();
  final _Hotelroom = TextEditingController();
  final _Hotelperson = TextEditingController();
  final _Hoteltype = TextEditingController();
  final _Hotelcity = TextEditingController();
  final _Hotelimage = TextEditingController();
  FirebaseAuth user = FirebaseAuth.instance;
  late int price;
  var did = DateTime.now().millisecondsSinceEpoch;

  addHotel() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      print("Form is vaid ");

      print('Data for login ');

      try {
        await firestore
            .collection('app')
            .doc('Services')
            .collection('Hotels')
            .doc('${user.currentUser!.uid}$did')
            .set({
          'name': _Hotelname.text,
          'Hotel_price': int.parse(_Hotelprice.text),
          'Hotel_location': _Hotellocation.text,
          'Hotel_rooms': _Hotelroom.text,
          'Hotel_city': _Hotelcity.text,
          'Active_rooms': '3',
          'Stars': _Hoteltype.text,
          'Room_capacity': _Hotelperson.text,
          'admin_id': user.currentUser!.uid,
          'hotel_imageURL': imageUrl,
        });
        setState(() {
          imageUrl = '';
        });
      } on FirebaseException catch (e) {
        displayMessage(e.toString());
      }
    }
    _Hotelname.clear();
    _Hotelprice.clear();
    _Hotellocation.clear();
    _Hotelroom.clear();
    _Hotelcity.clear();
    _Hotelimage.clear();
    _Hoteltype.clear();
    _Hotelperson.clear();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> setImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );
    final user = auth.currentUser;
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref('/hotelimg/$did');
    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      setState(() {
        imageUrl = value;
      });
      displayMessage("image uploaded successfully");
    }).onError((error, stackTrace) {
      displayMessage(error.toString());
    });
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

                SizedBox(height: 30),
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.teal[300],
                            borderRadius: BorderRadius.circular(100.0)),
                        child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.teal[300],
                                borderRadius: BorderRadius.circular(100)),
                            child: imageUrl == ""
                                ? ClipOval(
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(48.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.teal[300],
                                      ),
                                    ),
                                  )
                                : ClipOval(
                                    child: SizedBox.fromSize(
                                        size: const Size.fromRadius(48.0),
                                        child: Image.network(imageUrl)),
                                  )),
                      ),
                      Positioned(
                          bottom: 0,
                          right: -25,
                          child: RawMaterialButton(
                            onPressed: () {
                              setImage();
                            },
                            elevation: 2.0,
                            fillColor: Colors.white,
                            padding: const EdgeInsets.all(15.0),
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.teal,
                            ),
                          )),
                    ],
                  ),
                ),

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
