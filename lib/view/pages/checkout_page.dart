import 'package:diyo/shared/method.dart';
import 'package:diyo/shared/theme.dart';
import 'package:diyo/view/widgets/cart_item.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../bloc/cart/cart_provider.dart';
import '../widgets/buttons.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildCheckoutButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: _buildAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        child: Column(
          children: [
            _buildOrderTitle(context),
            _orderList(context),
            _subTotalPrice(context),
            _addPromoCode()
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: redColor,
      elevation: 0,
      title: Text(
        'Pesanan (Meja Diyo-1)',
        style: primaryTextStyle.copyWith(
          fontSize: 16.sp,
          fontWeight: semiBold,
          color: whiteColor,
        ),
      ),
    );
  }

  Widget _buildOrderTitle(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Pesananku",
            style: primaryTextStyle.copyWith(
              fontSize: 22.sp,
              fontWeight: semiBold,
            ),
          ),
          _buildAddMenuButton(context)
        ],
      ),
    );
  }

  Widget _buildAddMenuButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 6.w,
          vertical: 4.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: blackColor.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.restaurant,
              color: redColor,
            ),
            SizedBox(
              width: 6.w,
            ),
            Text(
              "Add Menu",
              style: primaryTextStyle.copyWith(
                fontWeight: medium,
                color: redColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _orderList(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Column(
        children: cartProvider.carts
            .map(
              (cart) => CartItem(cart: cart),
            )
            .toList(),
      ),
    );
  }

  Widget _subTotalPrice(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Column(
      children: [
        Divider(
          color: greyColor,
          thickness: 0.5,
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          children: [
            Text(
              'Subtotal',
              style: primaryTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            const Spacer(),
            Text(
              "Rp ${formatCurrency(cartProvider.totalPrice())}",
              style: primaryTextStyle.copyWith(
                fontWeight: medium,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _addPromoCode() {
    return Container(
      margin: EdgeInsets.only(top: 30.h),
      child: Column(
        children: [
          Divider(
            color: greyColor.withOpacity(0.2),
            thickness: 12,
          ),
          Container(
            margin: EdgeInsets.only(top: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Kode Promo",
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  "Masukan",
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: light,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return BasketButton(
      title: "Checkout",
      onPressed: () {
        Navigator.pop(context);
        cartProvider.removeAllCart();
      },
      price: formatCurrency(cartProvider.totalPrice()),
      quantity: cartProvider.totalItems().toString(),
    );
  }
}
