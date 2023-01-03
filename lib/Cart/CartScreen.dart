import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CART'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
                child: TextButton(onPressed: () {}, child: Text('CHECKOUT')))
          ],
        ),
      ),
    );
  }
}
