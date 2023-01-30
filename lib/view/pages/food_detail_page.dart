import 'package:cached_network_image/cached_network_image.dart';
import 'package:diyo/models/food_model.dart';
import 'package:diyo/shared/method.dart';
import 'package:diyo/view/widgets/buttons.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../bloc/cart/cart_provider.dart';
import '../../shared/theme.dart';

class FoodDetailPage extends StatefulWidget {
  final FoodModel food;

  const FoodDetailPage({super.key, required this.food});

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildAddToCartButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          _buildContent(),
          _buildBackButton(context),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          margin: EdgeInsets.only(
            top: 50.h,
            left: 20.w,
          ),
          decoration: BoxDecoration(
            color: redColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.chevron_left,
            size: 28,
            color: whiteColor,
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFoodImage(),
        _buildFoodInfo(),
        _buildSpecialRequest(),
        _buildQuantity()
      ],
    );
  }

  Widget _buildFoodImage() {
    return Align(
      alignment: Alignment.topCenter,
      child: CachedNetworkImage(
        imageUrl: widget.food.imageUrl,
        height: 310.h,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildFoodInfo() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      margin: EdgeInsets.only(top: 20.h),
      child: Column(
        children: [
          _builFoodNameAndPrice(),
          Divider(
            color: redColor,
            thickness: 1.4.h,
          )
        ],
      ),
    );
  }

  Widget _builFoodNameAndPrice() {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.food.name,
            style: primaryTextStyle.copyWith(
              fontSize: 22.sp,
              fontWeight: bold,
            ),
          ),
        ),
        Text(
          formatCurrency(widget.food.price),
          style: primaryTextStyle.copyWith(
            fontSize: 22.sp,
            fontWeight: bold,
            color: redColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialRequest() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      margin: EdgeInsets.only(top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Special Request',
            style: primaryTextStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: semiBold,
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          TextFormField(
            style: primaryTextStyle.copyWith(
              fontWeight: light,
            ),
            cursorColor: blackColor,
            decoration: InputDecoration.collapsed(
              hintText: "Catatan untuk restoran",
              hintStyle: primaryTextStyle.copyWith(
                fontWeight: light,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantity() {
    return Container(
      margin: EdgeInsets.only(top: 60.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSubstractButton(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              quantity.toString(),
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: medium,
              ),
            ),
          ),
          _buildAddButton(),
        ],
      ),
    );
  }

  Widget _buildSubstractButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (quantity != 0) {
            quantity -= 1;
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: blackColor.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          Icons.remove,
          color: redColor,
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          quantity += 1;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: blackColor.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          Icons.add,
          color: redColor,
        ),
      ),
    );
  }

  Widget _buildAddToCartButton(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    if (quantity != 0) {
      return BasketButton(
        title: "Add to Basket",
        onPressed: () {
          try {
            cartProvider.addFood(
              widget.food,
              quantity,
            );
            Navigator.pop(context);
          } catch (e) {
            rethrow;
          }
        },
        price: formatCurrency(quantity * widget.food.price),
        quantity: quantity.toString(),
      );
    }
    return BasketButton(
      title: "Remove from Basket",
      onPressed: () {
        try {
          cartProvider.removeCart(
            widget.food.id,
          );
          Navigator.pop(context);
        } catch (e) {
          rethrow;
        }
      },
      price: formatCurrency(quantity * widget.food.price),
      quantity: "0",
    );
  }
}
