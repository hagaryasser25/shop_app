import 'package:flutter/widgets.dart';
import 'package:shop_app/models/product.dart';

import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [
    Product(
      title: 'Sweatshirt dress',
      description:
          'Short dress in sweatshirt fabric made from a cotton blend with a high collar, zip at the top of the front and long, cuffed sleeves. Soft brushed inside.',
      price: 499.00,
      imageUrl:
          'https://eg.hm.com/sites/g/files/hm/assets-shared/HNM/13437168/126ba7d05229270b2bd00c742ccce8ef951a6a88/1/126ba7d05229270b2bd00c742ccce8ef951a6a88.jpg',
      collectionName: 'Dresses',
      isFavourite: false,
      isPopular: false,
    ),
    Product(
      title: 'Ribbed dress',
      description:
          'Short, fitted, sleeveless dress in ribbed cotton jersey with a collar and a V-shaped opening at the front. Unlined.',
      price: 399.00,
      imageUrl:
          'https://eg.hm.com/sites/g/files/hm/assets-shared/HNM/13636176/097ad005fb6da05ab08ce3f8da8665b1b15ad2a3/1/097ad005fb6da05ab08ce3f8da8665b1b15ad2a3.jpg',
      collectionName: 'Dresses',
      isFavourite: false,
      isPopular: true,
    ),
    Product(
      title: 'Cut-out dress',
      description:
          'Short, fitted dress in soft cotton jersey. Sleeveless with a narrow cut at the top and cut-out section at the back. Unlined.',
      price: 399.00,
      imageUrl:
          'https://eg.hm.com/sites/g/files/hm/assets-shared/HNM/13656593/0f38b6be7059427bf82df657ab1868411c8c643b/1/0f38b6be7059427bf82df657ab1868411c8c643b.jpg',
      collectionName: 'Dresses',
      isFavourite: false,
      isPopular: true,
    ),
    Product(
      title: 'Cropped sweater',
      description:
          'Cropped sweater vest in a soft, fine knit containing some wool with a V-neck front and back, and a ribbed hem.',
      price: 199.00,
      imageUrl:
          'https://eg.hm.com/sites/g/files/hm/assets-shared/HNM/13631855/24dde980ce6b30f284905d99cfa6d914144d3d9f/1/24dde980ce6b30f284905d99cfa6d914144d3d9f.jpg',
      collectionName: 'Tops',
      isFavourite: false,
      isPopular: true,
    ),
    Product(
      title: 'Print-motif T-shirt',
      description:
          'Relaxed-fit T-shirt in cotton jersey with a print motif and round, rib-trimmed neckline.',
      price: 249.00,
      imageUrl:
          'https://eg.hm.com/sites/g/files/hm/assets-shared/HNM/13671124/0945797bb8c473895a272998240c85ddc49295d7/1/0945797bb8c473895a272998240c85ddc49295d7.jpg',
      collectionName: 'Tops',
      isFavourite: false,
      isPopular: false,
    ),
    Product(
      title: 'button-placket T-shirt',
      description:
          'Fitted T-shirt in ribbed cotton jersey with a wide neckline, pearly button placket and sleeves that finish above the elbow.',
      price: 229.00,
      imageUrl:
          'https://eg.hm.com/sites/g/files/hm/assets-shared/HNM/13671308/d462bb3a8e7a8287f24b8e6f65b6165591ca645d/1/d462bb3a8e7a8287f24b8e6f65b6165591ca645d.jpg',
      collectionName: 'Tops',
      isFavourite: false,
      isPopular: false,
    ),
  ];

  List<Product> get products {
    return _products;
  }

  Product findByTitle(String productTitle) {
    return _products.firstWhere((element) => element.title == productTitle);
  }

  List<Product> get popularProducts {
    return _products.where((element) => element.isPopular).toList();
  }

  List<Product> findByCollection(String collectionnName) {
    List _collectionList = _products
        .where((element) => element.collectionName
            .toLowerCase()
            .contains(collectionnName.toLowerCase()))
        .toList();
    return _collectionList;
  }
  List<Product> searchQuery(String searchText) {
    List _searchList = _products
        .where((element) => element.title
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();
    return _searchList;
  }
}
