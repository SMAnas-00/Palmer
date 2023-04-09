// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:palmer/Screens/HomeScreen.dart';

// class CheckOutScreen extends StatefulWidget {
//   const CheckOutScreen({super.key});

//   @override
//   State<CheckOutScreen> createState() => _CheckOutScreenState();
// }

// class _CheckOutScreenState extends State<CheckOutScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         margin: EdgeInsets.fromLTRB(140, 120, 0, 0),
//         child: Column(
//           children: [
//             Lottie.asset('images/done.json',
//                 height: 50, width: 50, repeat: false),
//             Text('Booking Successfull'),
//             SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: () => Navigator.pushReplacement(
//                   context, MaterialPageRoute(builder: (context) => MyHome())),
//               child: Text('BACK'),
//               style:
//                   ElevatedButton.styleFrom(backgroundColor: Colors.teal[300]),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../Screens/HomeScreen.dart';

class CardDetails extends StatefulWidget {
  @override
  _CardDetailsState createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  String cardNumber = '';
  String expiryDate = '';
  String cvv = '';

  @override
  Widget build(BuildContext context) {
    final BackArrow = IconButton(
        color: Colors.white,
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHome()));
        },
        icon: Icon(Icons.arrow_back));
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Details'),
        leading: BackArrow,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Card Number',
              ),
              onChanged: (value) {
                setState(() {
                  cardNumber = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Expiry Date',
                    ),
                    onChanged: (value) {
                      setState(() {
                        expiryDate = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'CVV',
                    ),
                    onChanged: (value) {
                      setState(() {
                        cvv = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
