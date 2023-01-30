import 'package:diyo/models/food_model.dart';

class CartModel {
  final int id;
  final FoodModel food;
  int quantity;

  CartModel({
    required this.id,
    required this.food,
    required this.quantity,
  });

  double getTotalPrice() {
    double totalPrice = (food.price * quantity).toDouble();
    return totalPrice;
  }
}
