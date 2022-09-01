import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/cart_attr.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttr> _cartItems = {};

  Map<String, CartAttr> get getCartItems {
    return {..._cartItems};
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addProductToCart(
    String productTitle,
    double price,
    String collection,
    String imageUrl,
  ) {
    if (_cartItems.containsKey(productTitle)) {
      _cartItems.update(
          productTitle,
          (existingCartItem) => CartAttr(
                id: existingCartItem.id,
                title: existingCartItem.title,
                imageUrl: existingCartItem.imageUrl,
                collection: existingCartItem.collection,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity + 1,
              ));
    } else {
      _cartItems.putIfAbsent(
          productTitle,
          () => CartAttr(
                id: DateTime.now().toString(),
                title: productTitle,
                imageUrl: imageUrl,
                collection: collection,
                price: price,
                quantity: 1,
              ));
    }
    notifyListeners();
  }

  void reduceItemByOne(
    String productTitle,
    double price,
    String collection,
    String imageUrl,
  ) {
    if (_cartItems.containsKey(productTitle)) {
      _cartItems.update(
          productTitle,
          (existingCartItem) => CartAttr(
                id: existingCartItem.id,
                title: existingCartItem.title,
                imageUrl: existingCartItem.imageUrl,
                collection: existingCartItem.collection,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity -1,
              ));
    }
    notifyListeners();
  }
  void removeItem(String productTitle) {
    _cartItems.remove(productTitle);
    notifyListeners();
  }
  void clearCart(){
    _cartItems.clear();
    notifyListeners();
  }
}
