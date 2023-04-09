import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palmer/Cart/flightCart.dart';
import 'package:palmer/Screens/HomeScreen.dart';

import '../Cart/HotelCart.dart';
import '../Cart/checkoutScreen.dart';
import '../Cart/transportCart.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final BackArrow = IconButton(
        color: Colors.white,
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHome()));
        },
        icon: Icon(Icons.arrow_back));
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: BackArrow,
            automaticallyImplyLeading: false,
            actions: [
              GestureDetector(
                child: Container(
                    margin: EdgeInsets.fromLTRB(0, 12, 8, 0),
                    child: Text(
                      'CHECKOUT',
                      style: GoogleFonts.righteous(),
                    )),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => CardDetails()));
                },
              )
            ],
            title: Text('CART'),
            bottom: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                tabs: [
                  Tab(
                    child: Text('Hotel'),
                  ),
                  Tab(
                    child: Text('Transport'),
                  ),
                  Tab(
                    child: Text('Flight'),
                  )
                ]),
          ),
          body: TabBarView(children: [
            HotelCart(),
            TransportCart(),
            flightCart(),
          ]),
        ));
  }
}
