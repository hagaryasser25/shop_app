import 'package:flutter/widgets.dart';

class FavAttr with ChangeNotifier {
  final String id;
  final String imageUrl;
  final String title;
  final String collection;
  final double price;

  FavAttr({
    this.id, 
    this.imageUrl,
    this.title,
    this.collection,
    this.price,
  });
}