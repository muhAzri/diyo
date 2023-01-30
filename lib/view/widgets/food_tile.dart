import 'package:cached_network_image/cached_network_image.dart';
import 'package:diyo/models/food_model.dart';
import 'package:diyo/shared/method.dart';
import 'package:diyo/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodTile extends StatelessWidget {
  final FoodModel food;
  final VoidCallback onTap;

  const FoodTile({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            _buildFoodName(),
            _buildPrice(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: CachedNetworkImage(
        imageUrl: food.imageUrl,
        width: 120.w,
        height: 80.h,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildFoodName() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 20.w),
        child: Text(
          food.name,
          style: primaryTextStyle.copyWith(
            fontSize: 16,
            fontWeight: medium,
          ),
        ),
      ),
    );
  }

  Widget _buildPrice() {
    return Text(
      formatCurrency(food.price),
      style: primaryTextStyle.copyWith(
        fontSize: 16,
        fontWeight: medium,
      ),
    );
  }
}
