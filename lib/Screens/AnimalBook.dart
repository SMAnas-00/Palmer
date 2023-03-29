import 'package:flutter/material.dart';
import 'package:palmer/Screens/tripScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Services/Tickets/Flight.dart';
import '../main.dart';
import 'HomeScreen.dart';

class AnimalBookingPage extends StatefulWidget {
  @override
  _AnimalBookingPageState createState() => _AnimalBookingPageState();
}

class _AnimalBookingPageState extends State<AnimalBookingPage> {
  String _animalType = 'GOAT - 10,000';
  int _numberOfAnimals = 1;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth user = FirebaseAuth.instance;

  final List<String> _animalTypes = [
    'GOAT - 10,000',
    'GOAT - 15,000',
    'GOAT - 18,000',
    'GOAT - 20,000',
  ];

  @override
  Widget build(BuildContext context) {
    final BackArrow = IconButton(
        color: Colors.white,
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => BookTrip()));
        },
        icon: Icon(Icons.arrow_back));
    return Scaffold(
      appBar: AppBar(
        title: Text('Animal Booking'),
        leading: BackArrow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select animal type:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    DropdownButton(
                      value: _animalType,
                      items: _animalTypes.map((animalType) {
                        return DropdownMenuItem(
                          value: animalType,
                          child: Text(animalType),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _animalType = value!;
                        });
                      },
                    ),
                  ]),
            ),
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.0),
                    Text(
                      'Number of animals:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              if (_numberOfAnimals > 1) {
                                _numberOfAnimals--;
                              }
                              if (_numberOfAnimals <= 0) {
                                _numberOfAnimals = 0;
                              }
                            });
                          },
                          backgroundColor: (_numberOfAnimals <= 1)
                              ? Colors.black26
                              : Colors.teal,
                          child: Icon(Icons.remove),
                        ),
                        SizedBox(width: 16.0),
                        Text(
                          _numberOfAnimals.toString(),
                          style: TextStyle(fontSize: 24.0),
                        ),
                        SizedBox(width: 16.0),
                        FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              if (_numberOfAnimals >= 6) {
                                _numberOfAnimals = 6;
                              } else {
                                _numberOfAnimals++;
                              }
                            });
                          },
                          backgroundColor: (_numberOfAnimals >= 6)
                              ? Colors.black26
                              : Colors.teal,
                          child: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ]),
            ),
            SizedBox(height: 32.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await firestore
                      .collection('app')
                      .doc('Services')
                      .collection('requests')
                      .doc('${user.currentUser!.uid}')
                      .update({
                    'Number_of_animal': _numberOfAnimals,
                    'Animal_type': _animalType
                  }).then((value) {
                    displayMessage("request has been sent");
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FlightScreen()));
                  }).onError((error, stackTrace) =>
                          displayMessage(error.toString()));
                },
                child: Text('Book Animal'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
