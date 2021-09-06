import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    int totalItems = 0;
    _items.forEach(
      (key, cartItem) {
        totalItems += cartItem.quantity;
      },
    );
    return totalItems;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, itemCart) {
      total += itemCart.price * itemCart.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id,
          (actualItem) => CartItem(
              imgUrl: actualItem.imgUrl,
              id: actualItem.id,
              productId: actualItem.productId,
              name: actualItem.name,
              quantity: actualItem.quantity + 1,
              price: actualItem.price));
    } else {
      _items.putIfAbsent(
          product.id,
          () => CartItem(
              imgUrl: product.imgUrl,
              id: Random().nextDouble().toString(),
              productId: product.id,
              name: product.name,
              quantity: 1,
              price: product.price));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
