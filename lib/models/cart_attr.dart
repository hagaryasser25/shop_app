import 'package:flutter/widgets.dart';

class CartAttr with ChangeNotifier {
  final String id;
  final String imageUrl;
  final String title;
  final String collection;
  final double price;
  final int quantity;

  CartAttr({
    this.id, 
    this.imageUrl,
    this.title,
    this.collection,
    this.price,
    this.quantity,
  });
}
