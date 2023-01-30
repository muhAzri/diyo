import 'package:diyo/bloc/cart/cart_provider.dart';
import 'package:diyo/bloc/category/category_bloc.dart';
import 'package:diyo/bloc/food/food_bloc.dart';
import 'package:diyo/bloc/restaurant/restaurant_bloc.dart';
import 'package:diyo/view/pages/checkout_page.dart';
import 'package:diyo/view/pages/home_page.dart';
import 'package:diyo/view/pages/success_checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RestaurantBloc(),
        ),
        BlocProvider(
          create: (context) => FoodBloc(),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (context) => CartProvider(),
        child: ScreenUtilInit(
          designSize: const Size(430, 932),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              routes: {
                '/': (context) => const HomePage(),
                '/checkout': (context) => const CheckoutPage(),
                '/checkout-success': (context) => const SuccessChekoutPage(),
              },
            );
          },
        ),
      ),
    );
  }
}
