import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(140, 120, 0, 0),
        child: Column(
          children: [
            Lottie.asset('images/done.json',
                height: 50, width: 50, repeat: false),
            Text('Booking Successfull'),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('BACK'),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.teal[300]),
            )
          ],
        ),
      ),
    );
  }
}
