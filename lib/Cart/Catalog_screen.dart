import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palmer/Cart/CartScreen.dart';
import 'package:palmer/Cart/CatalogProducts.dart';
import 'package:palmer/Login&Signup.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ScreenLoginSignup()));
          },
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          CatalogProducts(),
          ElevatedButton(
              onPressed: () => Get.to(() => CartScreen()),
              child: Text('Go to Cart'))
        ],
      )),
    );
  }
}
