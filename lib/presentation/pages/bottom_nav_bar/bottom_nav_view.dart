import 'package:cart_system/app/di.dart';
import 'package:cart_system/presentation/pages/bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:cart_system/presentation/pages/cart/cart_view.dart';
import 'package:cart_system/presentation/pages/checkout/cubit/promo_code_cubit.dart';
import 'package:cart_system/presentation/pages/products/product_view.dart';
import 'package:cart_system/presentation/resources/colors_manager.dart';
import 'package:cart_system/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared_cubits/add_to_cart/add_to_cart_cubit.dart';
import '../../shared_cubits/delete_from_cart/delete_from_cart_cubit.dart';
import '../../shared_cubits/get_quantity/get_quantity_cubit.dart';
import '../cart/cubit/get_cart/get_cart_cubit.dart';
import '../products/cubit/product_cubit.dart';

class BottomNavView extends StatelessWidget {
  const BottomNavView({super.key});

  @override
  Widget build(BuildContext context) {
    productModule();
    cartModule();
    bottomNavBarModule();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => instance<BottomNavCubit>(),
        ),
        BlocProvider(
          create: (BuildContext context) => instance<ProductCubit>()..getProducts(),
        ),
        BlocProvider(
          create: (BuildContext context) => instance<AddToCartCubit>(),
        ),
        BlocProvider(
          create: (BuildContext context) => instance<GetCartCubit>()..getCartItems(),
        ),
        BlocProvider(
          create: (BuildContext context) => instance<DeleteFromCartCubit>(),
        ),
        BlocProvider(
          create: (BuildContext context) => instance<GetQuantityCubit>(),
        ),
      ],
      child: BlocBuilder<BottomNavCubit, int>(
        builder: (BuildContext context, int index) {
          return Scaffold(
            backgroundColor: ColorsManager.offWhite,
            body: IndexedStack(
              index: index,
              children: [
                ProductView(),
                CartView()
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
                // selectedFontSize: 18,
                // iconSize: 28,
                elevation: 0,
                currentIndex: index,
                onTap: (index){
                  context.read<BottomNavCubit>().changeBottomNavBarIndex(index);
                  if(index == 1) {
                    context.read<GetCartCubit>().getCartItems();
                  }
                },
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.local_mall), label: StringsManager.products),
                  BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: StringsManager.cart)
                ]
            ),
          );
        },
      ),
    );
  }
}
