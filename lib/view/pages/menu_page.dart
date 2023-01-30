import 'package:cached_network_image/cached_network_image.dart';
import 'package:diyo/bloc/category/category_bloc.dart';
import 'package:diyo/bloc/food/food_bloc.dart';
import 'package:diyo/models/category_model.dart';
import 'package:diyo/models/restaurant_model.dart';
import 'package:diyo/shared/method.dart';
import 'package:diyo/shared/theme.dart';
import 'package:diyo/view/pages/food_detail_page.dart';
import 'package:diyo/view/widgets/category_tile.dart';
import 'package:diyo/view/widgets/food_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../bloc/cart/cart_provider.dart';
import '../../models/food_model.dart';
import '../widgets/buttons.dart';

class MenuPage extends StatefulWidget {
  final String? value;
  final RestaurantModel? restaurant;

  const MenuPage({
    super.key,
    this.value,
    this.restaurant,
  });

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  var tableNumber = '';

  String selectedCategory = '';

  @override
  void initState() {
    var value = widget.value;
    if (value != null) {
      var qrData = value.split('-');
      tableNumber = qrData[1];
    }

    if (value == null) {
      tableNumber = '1';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildViewCartButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ListView(
        children: [
          Stack(
            children: [
              _buildRestoImage(),
              _buildContentList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRestoImage() {
    return Align(
      alignment: Alignment.topCenter,
      child: widget.restaurant != null
          ? CachedNetworkImage(imageUrl: widget.restaurant!.imageUrl!)
          : Image.asset(
              'assets/images/dummy_restaurant.jpeg',
            ),
    );
  }

  Widget _buildContentList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBackButton(),
          _buildTableNumber(),
          _buildRestaurantInfo(),
          _buildMenu(),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        },
        child: Container(
          margin: EdgeInsets.only(top: 20.h),
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

  Widget _buildTableNumber() {
    return IntrinsicWidth(
      child: Container(
        margin: EdgeInsets.only(top: 220.h),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: redColor,
        ),
        child: Row(
          children: [
            Icon(
              Icons.table_restaurant,
              color: whiteColor,
            ),
            SizedBox(
              width: 4.w,
            ),
            Text(
              'No. Meja $tableNumber',
              style: primaryTextStyle.copyWith(
                fontSize: 16.sp,
                fontWeight: bold,
                color: whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantInfo() {
    return Container(
      margin: EdgeInsets.only(top: 30.h),
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: greyColor.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.restaurant != null
                ? widget.restaurant!.name
                : "Restaurant Name",
            style: primaryTextStyle.copyWith(
              fontSize: 24,
              fontWeight: bold,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            widget.restaurant != null
                ? widget.restaurant!.category
                : 'Japanese Food',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            widget.restaurant != null
                ? widget.restaurant!.address
                : 'Permata Sari',
            style: primaryTextStyle,
          ),
          SizedBox(
            height: 12.h,
          ),
          Divider(
            height: 1,
            color: greyColor,
          ),
          SizedBox(
            height: 12.h,
          ),
          _buildOpeningInfo(),
        ],
      ),
    );
  }

  Widget _buildOpeningInfo() {
    return Row(
      children: [
        Icon(
          Icons.access_time,
          color: redColor,
        ),
        SizedBox(
          width: 6.w,
        ),
        Text(
          'BUKA',
          style: primaryTextStyle.copyWith(
            fontSize: 16,
            fontWeight: bold,
            color: redColor,
          ),
        ),
        SizedBox(
          width: 12.w,
        ),
        Text(
          widget.restaurant != null
              ? 'Until ${widget.restaurant!.timeClose} today'
              : 'Until 19.00 today',
          style: primaryTextStyle,
        ),
        const Spacer(),
        _buildDistanceInfo(),
      ],
    );
  }

  Widget _buildDistanceInfo() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 2.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: redColor,
      ),
      child: Row(
        children: [
          Icon(
            Icons.pin_drop,
            color: whiteColor,
            size: 18,
          ),
          SizedBox(
            width: 4.w,
          ),
          Text(
            widget.restaurant != null ? widget.restaurant!.distance : '1 Km',
            style: primaryTextStyle.copyWith(
              fontSize: 12,
              fontWeight: semiBold,
              color: whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenu() {
    return Container(
      margin: EdgeInsets.only(top: 30.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: greyColor.withOpacity(0.1),
      ),
      child: Column(
        children: [
          _buildCategory(),
          _buildFoods(),
        ],
      ),
    );
  }

  Widget _buildCategory() {
    context.read<CategoryBloc>().add(GetCategoriesEvent());

    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoaded) {
          if (selectedCategory == '') {
            selectedCategory = state.categories.first.name;
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: state.categories
                  .map(
                    (category) => _buildCategoryTile(category),
                  )
                  .toList(),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildCategoryTile(CategoryModel category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category.name;
        });
      },
      child: CategoryTile(
        category: category,
        isSelected: selectedCategory == category.name,
      ),
    );
  }

  Widget _buildFoods() {
    context.read<FoodBloc>().add(GetFoodsEvent());

    List<FoodModel> filterFoodList(List<FoodModel> foodList) {
      if (selectedCategory == '') {
        return foodList;
      }

      return foodList
          .where((food) => food.category == selectedCategory)
          .toList();
    }

    return BlocBuilder<FoodBloc, FoodState>(
      builder: (context, state) {
        if (state is FoodLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is FoodLoaded) {
          final filteredFoodList = filterFoodList(state.foods);

          return Container(
            margin: EdgeInsets.only(top: 40.h, bottom: 60.h),
            child: Column(
              children: filteredFoodList
                  .map((food) => FoodTile(
                      food: food,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodDetailPage(
                              food: food,
                            ),
                          ),
                        );
                      }))
                  .toList(),
            ),
          );
        }

        return Container();
      },
    );
  }

  Widget _buildViewCartButton(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    if (cartProvider.carts.isNotEmpty) {
      return BasketButton(
        title: "View Basket",
        onPressed: () {
          Navigator.pushNamed(context, '/checkout');
        },
        price: formatCurrency(cartProvider.totalPrice()),
        quantity: cartProvider.totalItems().toString(),
      );
    }
    return const SizedBox();
  }
}
