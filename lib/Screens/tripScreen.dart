import 'package:flutter/material.dart';
import 'package:palmer/Screens/HomeScreen.dart';

class BookTrip extends StatelessWidget {
  const BookTrip({super.key});

  @override
  Widget build(BuildContext context) {
    final BackArrow = IconButton(
        color: Colors.white,
        onPressed: () {
          //Navigator.pop(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHome()));
        },
        icon: Icon(Icons.arrow_back));
    return Scaffold(
      appBar: AppBar(
        leading: BackArrow,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 120),
          child: Column(
            children: [
              ElevatedButton(onPressed: () {}, child: Text('UMMRAHH')),
              ElevatedButton(onPressed: () {}, child: Text('Hajj'))
            ],
          ),
        ),
      ),
    );
  }
}
