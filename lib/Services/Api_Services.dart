import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:palmer/HomeScreen.dart';

class HotelDetails extends StatefulWidget {
  const HotelDetails({super.key});

  @override
  State<HotelDetails> createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  @override
  Widget build(BuildContext context) {
    final BackArrow = IconButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHome()));
        },
        icon: Icon(Icons.arrow_back));

    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels'),
        leading: BackArrow,
      ),
      body: Center(
        child: Container(
          child: ElevatedButton(
            onPressed: () {
              hotelSearch();
            },
            child: Text("Get Data"),
          ),
        ),
      ),
    );
  }
}

final qurrey = {'params1': 'london'};
final base = Uri.https('www.tripadvisor16.p.rapidapi.com',
    '/api/v1/flights/searchAirport', qurrey);

Future hotelSearch() async {
  final response = await http.get(base, headers: {
    'X-RapidAPI-Key': '33c358f4c7msh5b54fa8f5fa83bep1b1f0ejsn4a1efbcfb7a9',
    'X-RapidAPI-Host': 'tripadvisor16.p.rapidapi.com'
  });

  if (response.statusCode == 200) {
    return print(response.body);
  } else {
    throw Exception('Faild to Load');
  }
}
