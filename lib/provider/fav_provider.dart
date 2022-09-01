import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/cart_attr.dart';
import 'package:shop_app/models/fav_attr.dart';

class FavProvider with ChangeNotifier {
  Map<String, FavAttr> _favItems = {};

  Map<String, FavAttr> get getFavItems {
    return {..._favItems};
  }

  void addAndRemoveFromFav(
    String productTitle,
    double price,
    String collection,
    String imageUrl,
  ) {
    if (_favItems.containsKey(productTitle)) {
      removeItem(productTitle);
    } else {
      _favItems.putIfAbsent(
          productTitle,
          () => FavAttr(
                id: DateTime.now().toString(),
                title: productTitle,
                imageUrl: imageUrl,
                collection: collection,
                price: price,
              ));
    }
    notifyListeners();
  }

  void removeItem(String productTitle) {
    _favItems.remove(productTitle);
    notifyListeners();
  }

  void clearFav() {
    _favItems.clear();
    notifyListeners();
  }
}
