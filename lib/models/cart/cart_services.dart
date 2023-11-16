import 'package:compras_full/models/cart/cart_item.dart';
import 'package:flutter/material.dart';

class CartService with ChangeNotifier {
  final List<CartItem> _items = getItems();
  final List<CartItem> _cart = [];

  List<CartItem> get items => _items;

  List<CartItem> get cart => _cart;

  void addToCart(CartItem item) {
    _cart.add(item);
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _cart.remove(item);
    notifyListeners();
  }
}
