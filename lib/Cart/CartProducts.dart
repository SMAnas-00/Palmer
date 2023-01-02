import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palmer/Cart/Controllers/Cart_controller.dart';
import 'package:palmer/Cart/models/Product_model.dart';

class CartProducts extends StatelessWidget {
  final CartController controller1 = Get.find();
  CartProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: ListView.builder(
            itemCount: controller1.products.length,
            itemBuilder: (BuildContext context, int index) {
              return CartProductCard(
                controller: controller1,
                product: controller1.products.keys.toList()[index],
                quantity: controller1.products.values.toList()[index],
                index: index,
              );
            }),
      ),
    );
  }
}

class CartProductCard extends StatelessWidget {
  final CartController controller;
  final Product product;
  final int quantity;
  final int index;
  const CartProductCard(
      {super.key,
      required this.controller,
      required this.index,
      required this.product,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(product.imageurl),
          ),
          SizedBox(width: 20),
          Expanded(child: Text(product.name)),
          IconButton(
              onPressed: () {
                controller.removeProduct(product);
              },
              icon: Icon(Icons.remove_circle)),
          Text('${quantity}'),
          IconButton(
              onPressed: () {
                controller.addProduct(product);
              },
              icon: Icon(Icons.add_circle)),
        ],
      ),
    );
  }
}
