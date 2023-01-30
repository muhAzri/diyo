import 'dart:convert';

import 'package:diyo/models/restaurant_model.dart';
import 'package:flutter/services.dart';

class RestaurantService {
  Future<List<RestaurantModel>> getRestaurant() async {
    try {
      final jsonFile =
          await rootBundle.loadString('assets/json/restaurant.json');
      final result = jsonDecode(jsonFile);

      final List<RestaurantModel> list = List<RestaurantModel>.from(
        result['restaurant'].map(
          (category) => RestaurantModel.fromJson(category),
        ),
      ).toList();

      return list;
    } catch (e) {
      rethrow;
    }
  }
}
