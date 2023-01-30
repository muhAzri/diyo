import 'dart:convert';

import 'package:diyo/models/food_model.dart';
import 'package:flutter/services.dart';

class FoodService {
  Future<List<FoodModel>> getFoods() async {
    try {
      final jsonFile = await rootBundle.loadString('assets/json/foods.json');
      final result = jsonDecode(jsonFile);

      final List<FoodModel> list = List<FoodModel>.from(
        result['foods'].map(
          (category) => FoodModel.fromJson(category),
        ),
      ).toList();

      return list;
    } catch (e) {
      rethrow;
    }
  }
}
