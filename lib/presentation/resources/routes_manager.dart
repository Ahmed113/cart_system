import 'package:cart_system/app/di.dart';
import 'package:cart_system/data/data_source/promo_code_local_data_source.dart';
import 'package:cart_system/data/repo_impl/promo_code_repo_impl.dart';
import 'package:cart_system/domain/repo/promo_code_repo.dart';
import 'package:cart_system/domain/usecase/promo_code_usecase.dart';
import 'package:cart_system/presentation/pages/cart/cart_view.dart';
import 'package:cart_system/presentation/pages/checkout/checkout_view.dart';
import 'package:cart_system/presentation/pages/checkout/cubit/promo_code_cubit.dart';
import 'package:cart_system/presentation/pages/products/product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_source/cart_local__data_source.dart';
import '../../data/data_source/product_local_data_source.dart';
import '../../data/repo_impl/cart_item_repo_impl.dart';
import '../../data/repo_impl/products_repo_impl.dart';
import '../../domain/usecase/cart_item_usecases.dart';
import '../../domain/usecase/get_products_usecase.dart';
import '../pages/cart/cubit/get_cart/get_cart_cubit.dart';
import '../pages/products/cubit/product_cubit.dart';
import '../shared_cubits/add_to_cart/add_to_cart_cubit.dart';
import '../shared_cubits/delete_from_cart/delete_from_cart_cubit.dart';
import '../shared_cubits/get_quantity/get_quantity_cubit.dart';

class Routes{
  static const String productViewRoute = '/productView';
  static const String cartViewRoute = '/cartView';
  static const String checkOutRoute = '/checkOutView';
}

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name) {
      case Routes.productViewRoute:
        productModule();
        return MaterialPageRoute(builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) {
                  return ProductCubit(GetProductsUsecase(ProductsRepoImpl(ProductLocalDataSourceImpl())));
                },
              ),
              BlocProvider(
                create: (BuildContext context) {
                  return AddToCartCubit(AddCartItemUsecase(CartItemRepoImpl(CartLocalDataSourceImpl())));
                },
              ),
              BlocProvider(
                create: (BuildContext context) {
                  return DeleteFromCartCubit(DeleteCartItemUsecase(CartItemRepoImpl(CartLocalDataSourceImpl())));
                },
              ),
              BlocProvider(
                create: (BuildContext context) {
                  return GetQuantityCubit(GetQuantityCartItemUsecase(CartItemRepoImpl(CartLocalDataSourceImpl())));
                },
              ),
            ],
            child: ProductView()));
      case Routes.cartViewRoute:
        cartModule();
        return MaterialPageRoute(builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) {
                  return AddToCartCubit(AddCartItemUsecase(CartItemRepoImpl(CartLocalDataSourceImpl())));
                },
              ),
              BlocProvider(
                create: (BuildContext context) {
                  return GetCartCubit(GetAllCartItemsUsecase(CartItemRepoImpl(CartLocalDataSourceImpl())));
                },
              ),
              BlocProvider(
                create: (BuildContext context) {
                  return DeleteFromCartCubit(DeleteCartItemUsecase(CartItemRepoImpl(CartLocalDataSourceImpl())));
                },
              ),
              BlocProvider(
                create: (BuildContext context) {
                  return GetQuantityCubit(GetQuantityCartItemUsecase(CartItemRepoImpl(CartLocalDataSourceImpl())));
                },
              ),
            ],
            child: CartView()));
      case Routes.checkOutRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => BlocProvider(
            create: (BuildContext context) { 
              return  PromoCodeCubit(PromoCodeUsecase(PromoCodeRepoImpl(PromoCodeLocalDataSourceImpl())));
            },
            child: CheckoutView(itemsCount: args['items'], totalPrice: args['totalPrice'])));
      default:
        return unknownRoute();
    }
  }
  static Route<dynamic> unknownRoute(){
    return MaterialPageRoute(builder: (_) =>
        Scaffold(
          body: Center(child: Text('Wrong route'),),
        )
    );
  }
}