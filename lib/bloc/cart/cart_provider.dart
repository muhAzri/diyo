import 'package:diyo/models/food_model.dart';
import 'package:flutter/material.dart';

import '../../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _carts = [];

  List<CartModel> get carts => _carts;

  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  addFood(FoodModel food, int quantity) {
    if (isExist(food)) {
      int index = _carts.indexWhere((element) => element.food.id == food.id);
      _carts[index].quantity = quantity;
    } else {
      _carts.add(
        CartModel(
          id: _carts.length,
          food: food,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  getItemQuantity(FoodModel food) {
    if (isExist(food)) {
      int index = _carts.indexWhere((element) => element.food.id == food.id);
      int quantity = _carts[index].quantity;
      return quantity;
    }
  }

  removeCart(int id) {
    _carts.removeAt(id);
    notifyListeners();
  }

  removeAllCart() {
    _carts.clear();
    notifyListeners();
  }

  totalItems() {
    int total = 0;
    for (var item in _carts) {
      total += item.quantity;
    }
    return total;
  }

  totalPrice() {
    double total = 0;
    for (var item in _carts) {
      total += (item.quantity * item.food.price);
    }
    return total;
  }

  isExist(FoodModel product) {
    if (_carts.indexWhere((element) => element.id == product.id) == -1) {
      return false;
    } else {
      return true;
    }
  }
}
