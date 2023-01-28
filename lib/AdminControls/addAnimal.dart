import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:palmer/AdminControls/AdminDash.dart';

import '../main.dart';

class addAnimalScreen extends StatefulWidget {
  const addAnimalScreen({super.key});

  @override
  State<addAnimalScreen> createState() => _addAnimalScreenState();
}

class _addAnimalScreenState extends State<addAnimalScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final _animalprice = TextEditingController();

  addAnimal() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      print("Form is vaid ");

      print('Data for login ');

      var did = DateTime.now().microsecondsSinceEpoch;

      try {
        final user = FirebaseAuth.instance;
        await firestore
            .collection('app')
            .doc('Services')
            .collection('Animal')
            .doc(user.currentUser!.uid)
            .set({
          'animal_name': 'Goat/Sheep',
          'animal_price': _animalprice.text,
          'animal_id': user.currentUser!.uid
        });
      } on FirebaseException catch (e) {
        displayMessage(e.toString());
      }
      _animalprice.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final BackArrow = IconButton(
        color: Colors.teal,
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
        title: Text('Book Animal',
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
                  controller: _animalprice,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Animal Price',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Price Required';
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
                  onPressed: addAnimal,
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
