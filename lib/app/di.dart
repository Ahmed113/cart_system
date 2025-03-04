import 'package:cart_system/data/data_source/cart_local__data_source.dart';
import 'package:cart_system/data/data_source/product_local_data_source.dart';
import 'package:cart_system/data/data_source/promo_code_local_data_source.dart';
import 'package:cart_system/data/repo_impl/cart_item_repo_impl.dart';
import 'package:cart_system/data/repo_impl/products_repo_impl.dart';
import 'package:cart_system/domain/repo/products_repo.dart';
import 'package:cart_system/domain/repo/promo_code_repo.dart';
import 'package:cart_system/domain/usecase/cart_item_usecases.dart';
import 'package:cart_system/domain/usecase/get_products_usecase.dart';
import 'package:cart_system/domain/usecase/promo_code_usecase.dart';
import 'package:cart_system/presentation/pages/bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:cart_system/presentation/pages/cart/cubit/get_cart/get_cart_cubit.dart';
import 'package:cart_system/presentation/pages/checkout/cubit/promo_code_cubit.dart';
import 'package:cart_system/presentation/pages/products/cubit/product_cubit.dart';
import 'package:cart_system/presentation/shared_cubits/add_to_cart/add_to_cart_cubit.dart';
import 'package:cart_system/presentation/shared_cubits/delete_from_cart/delete_from_cart_cubit.dart';
import 'package:cart_system/presentation/shared_cubits/get_quantity/get_quantity_cubit.dart';
import 'package:get_it/get_it.dart';

import '../data/repo_impl/promo_code_repo_impl.dart';
import '../domain/repo/cart_item_repo.dart';

final GetIt instance = GetIt.instance;

void appModuleDi() {
  instance.registerLazySingleton<CartLocalDataSource>(() => CartLocalDataSourceImpl());
  instance.registerLazySingleton<ProductLocalDataSource>(() => ProductLocalDataSourceImpl());
  instance.registerLazySingleton<PromoCodeLocalDataSource>(() => PromoCodeLocalDataSourceImpl());
  instance.registerLazySingleton<CartItemRepo>(() => CartItemRepoImpl(instance<CartLocalDataSource>()));
  instance.registerLazySingleton<ProductsRepo>(() => ProductsRepoImpl(instance<ProductLocalDataSource>()));
  instance.registerLazySingleton<PromoCodeRepo>(() => PromoCodeRepoImpl(instance<PromoCodeLocalDataSource>()));
}

void cartModule() {
  if (!GetIt.instance.isRegistered<AddCartItemUsecase>()) {
    instance.registerFactory<AddCartItemUsecase>(() => AddCartItemUsecase(instance<CartItemRepo>()));
    instance.registerFactory<DeleteCartItemUsecase>(() => DeleteCartItemUsecase(instance<CartItemRepo>()));
    instance.registerFactory<GetAllCartItemsUsecase>(() => GetAllCartItemsUsecase(instance<CartItemRepo>()));
    instance.registerFactory<GetQuantityCartItemUsecase>(() => GetQuantityCartItemUsecase(instance<CartItemRepo>()));

    instance.registerFactory<AddToCartCubit>(() => AddToCartCubit(instance<AddCartItemUsecase>()));
    instance.registerFactory<DeleteFromCartCubit>(() => DeleteFromCartCubit(instance<DeleteCartItemUsecase>()));
    instance.registerFactory<GetCartCubit>(() => GetCartCubit(instance<GetAllCartItemsUsecase>()));
    instance.registerFactory<GetQuantityCubit>(() => GetQuantityCubit(instance<GetQuantityCartItemUsecase>()));
  }
}

void productModule(){
  if (!GetIt.instance.isRegistered<GetProductsUsecase>()) {
    instance.registerFactory<GetProductsUsecase>(() =>
        GetProductsUsecase(instance<ProductsRepo>()));
    instance.registerFactory<ProductCubit>(() =>
        ProductCubit(instance<GetProductsUsecase>()));
  }
}

void bottomNavBarModule(){
  if (!GetIt.instance.isRegistered<BottomNavCubit>()) {
    instance.registerFactory<BottomNavCubit>(() => BottomNavCubit());
  }
}

void promoCodeModule() {
  if (!GetIt.instance.isRegistered<PromoCodeCubit>()) {
    instance.registerFactory<PromoCodeUsecase>(() =>
        PromoCodeUsecase(instance<PromoCodeRepo>()));
    instance.registerFactory<PromoCodeCubit>(() =>
        PromoCodeCubit(instance<PromoCodeUsecase>()));
  }
}