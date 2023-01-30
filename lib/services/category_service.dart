import 'dart:convert';

import 'package:diyo/models/category_model.dart';
import 'package:flutter/services.dart';

class CategoryService {
  Future<List<CategoryModel>> getCategories() async {
    try {
      final jsonFile = await rootBundle.loadString('assets/json/category.json');
      final result = jsonDecode(jsonFile);

      final List<CategoryModel> list = List<CategoryModel>.from(
        result['categories'].map(
          (category) => CategoryModel.fromJson(category),
        ),
      ).toList();

      return list;
    } catch (e) {
      rethrow;
    }
  }
}
