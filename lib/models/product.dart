import 'package:flutter/widgets.dart';

class Product with ChangeNotifier{
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String collectionName;
  final bool isFavourite;
  final bool isPopular;

  Product(
      {
      this.title,
      this.description,
      this.price,
      this.imageUrl,
      this.collectionName,
      this.isFavourite,
      this.isPopular});
}
