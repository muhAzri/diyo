import 'package:diyo/shared/theme.dart';
import 'package:diyo/view/pages/scan_qr_page.dart';
import 'package:diyo/view/widgets/restaurant_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/restaurant/restaurant_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildScanButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildCustomBottomNav(),
      body: _buildContent(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: false,
      backgroundColor: redColor,
      title: Text(
        'DIYO',
        style: primaryTextStyle.copyWith(
          fontSize: 24.sp,
          fontWeight: semiBold,
          letterSpacing: 6.w,
          color: whiteColor,
        ),
      ),
    );
  }

  Widget _buildScanButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ScanQRPage(),
          ),
        );
      },
      backgroundColor: redColor,
      child: Icon(
        Icons.qr_code,
        size: 36.w,
      ),
    );
  }

  Widget _buildContent() {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      children: [
        _buildRestaurantTitle(),
        _buildRestaurantList(),
      ],
    );
  }

  Widget _buildRestaurantTitle() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Semua Restoran',
            style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantList() {
    context.read<RestaurantBloc>().add(GetRestaurantEvent());

    return Container(
      margin: EdgeInsets.only(top: 24.h),
      child: BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
          if (state is RestaurantLoaded) {
            return Column(
              children: state.restaurants
                  .map(
                    (restaurant) => RestaurantTile(restaurant: restaurant),
                  )
                  .toList(),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildCustomBottomNav() {
    return BottomNavigationBar(
      backgroundColor: whiteColor,
      currentIndex: currentIndex,
      fixedColor: redColor,
      onTap: (value) {
        setState(() {
          currentIndex = value;
        });
      },
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(
            Icons.home,
            size: 22,
            color: currentIndex == 0 ? redColor : blackColor,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Pesanan',
          icon: Icon(
            Icons.history,
            size: 22,
            color: currentIndex == 1 ? redColor : blackColor,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Favorit',
          icon: Icon(
            Icons.favorite,
            size: 22,
            color: currentIndex == 2 ? redColor : blackColor,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Akun',
          icon: Icon(
            Icons.person,
            size: 22,
            color: currentIndex == 3 ? redColor : blackColor,
          ),
        ),
      ],
    );
  }
}
