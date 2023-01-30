import 'package:diyo/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessChekoutPage extends StatelessWidget {
  const SuccessChekoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Transaksi Sukses",
              style: primaryTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Text(
              "Pesanan Anda Telah Diarahkan Ke Dapur",
              style: primaryTextStyle.copyWith(
                fontWeight: medium,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: redColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            child: Text(
              "Kembali Ke Home",
              style: primaryTextStyle.copyWith(
                  fontSize: 16, color: whiteColor, fontWeight: semiBold),
            ),
          ),
        ],
      ),
    );
  }
}
