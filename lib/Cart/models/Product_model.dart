import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final double price;
  final String imageurl;

  const Product({
    required this.name,
    required this.price,
    required this.imageurl,
  });

  // static Product fromSnapshot(DocumentSnapshot snap) {
  //   Product product = Product(
  //     name: snap['name'],
  //     price: snap['Hotel_price'],
  //     imageurl: snap['Hotel_image'],
  //   );
  //   return product;
  // }

  static const List<Product> products = [
    Product(
      name: 'Hotel',
      price: 10000.0,
      imageurl:
          'https://images.unsplash.com/photo-1535827841776-24afc1e255ac?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8aG90ZWxzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    ),
    Product(
      name: 'Tickets',
      price: 20000.0,
      imageurl:
          'https://images.unsplash.com/photo-1621632361333-4649f0b59adc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
    ),
    Product(
      name: 'Transport',
      price: 500.0,
      imageurl:
          'https://images.unsplash.com/photo-1613638377394-281765460baa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2FifGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    ),
  ];
}
