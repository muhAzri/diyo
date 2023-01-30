import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/theme.dart';

class BasketButton extends StatelessWidget {
  final String title;
  final String price;
  final String quantity;
  final VoidCallback onPressed;

  const BasketButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 24.w,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 24.w,
        ),
        decoration: BoxDecoration(
          color: redColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color.fromARGB(255, 171, 42, 42),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                child: Text(
                  quantity,
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: extraBold,
                    color: whiteColor,
                  ),
                ),
              ),
            ),
            Text(
              title,
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
                color: whiteColor,
              ),
            ),
            Text(
              'Rp $price',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
                color: whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
