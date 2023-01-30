import 'package:diyo/shared/method.dart';
import 'package:diyo/shared/theme.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../bloc/cart/cart_provider.dart';
import '../../models/cart_model.dart';

class CartItem extends StatelessWidget {
  final CartModel cart;
  const CartItem({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          _buildQuantity(),
          _buildFoodInfo(),
          _buildPrice(),
          _buildDeleteButton(context),
        ],
      ),
    );
  }

  Widget _buildQuantity() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: redColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        '${cart.quantity}x',
        style: primaryTextStyle.copyWith(
          fontWeight: semiBold,
          color: whiteColor,
        ),
      ),
    );
  }

  Widget _buildFoodInfo() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.food.name,
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            Text(
              cart.food.category,
              style: primaryTextStyle.copyWith(
                fontWeight: light,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrice() {
    return Text(
      formatCurrency(cart.quantity * cart.food.price),
      style: primaryTextStyle.copyWith(
        fontWeight: semiBold,
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return GestureDetector(
      onTap: () {
        cartProvider.removeCart(cart.id);
      },
      child: Container(
        margin: EdgeInsets.only(left: 8.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: redColor,
          ),
        ),
        child: Icon(
          Icons.close,
          color: redColor,
          size: 16.w,
        ),
      ),
    );
  }
}
