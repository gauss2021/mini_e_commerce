import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> cart = [];

  void addProductInCart(Map<String, dynamic> product) {
    cart.add(product);
    notifyListeners();
  }

  void removeProductInCart(Map<String, dynamic> product) {
    cart.remove(product);
    notifyListeners();
  }
}
