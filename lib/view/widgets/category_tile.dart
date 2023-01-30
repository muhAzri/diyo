import 'package:diyo/models/category_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/theme.dart';

class CategoryTile extends StatelessWidget {
  final bool isSelected;
  final CategoryModel category;

  const CategoryTile({
    super.key,
    required this.category,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: isSelected ? redColor : whiteColor,
      ),
      child: Text(
        category.name,
        style: primaryTextStyle.copyWith(
            fontSize: 16,
            fontWeight: medium,
            color: isSelected ? whiteColor : blackColor),
      ),
    );
  }
}
