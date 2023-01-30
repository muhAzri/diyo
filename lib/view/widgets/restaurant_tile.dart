import 'package:cached_network_image/cached_network_image.dart';
import 'package:diyo/models/restaurant_model.dart';
import 'package:diyo/shared/theme.dart';
import 'package:diyo/view/pages/scan_qr_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantTile extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantTile({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScanQRPage(restaurant: restaurant),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 18.h),
        child: Stack(
          children: [
            _buildTimeReady(),
            Container(
              width: double.infinity,
              height: 120.h,
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 14.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: blackColor,
                  width: 0.5.w,
                ),
              ),
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Row(
      children: [
        _buildImage(),
        _buildRestaurantInfo(),
        _buildRestaurantDistance()
      ],
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: CachedNetworkImage(
        imageUrl: restaurant.imageUrl!,
        width: 90.w,
        height: 90.h,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildRestaurantInfo() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurant.name,
              style: primaryTextStyle.copyWith(
                fontSize: 16.sp,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              restaurant.address,
              style: secondaryTextStyle.copyWith(
                fontWeight: light,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              restaurant.category,
              style: primaryTextStyle.copyWith(
                fontWeight: light,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantDistance() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(left: 12.w, right: 36.w),
        child: Text(
          restaurant.distance,
          style: primaryTextStyle.copyWith(
            fontSize: 16.sp,
            fontWeight: bold,
            color: redColor,
          ),
        ),
      ),
    );
  }

  Widget _buildTimeReady() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 80.w,
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
          vertical: 2.h,
        ),
        decoration: BoxDecoration(
          color: greyColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.access_time,
              size: 8,
            ),
            Text(
              restaurant.timeReady,
              style: primaryTextStyle.copyWith(
                fontSize: 12.sp,
                fontWeight: medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
