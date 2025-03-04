import 'package:cart_system/app/failure.dart';
import 'package:dartz/dartz.dart';

import '../entity/cart.dart';
import '../entity/cart_item.dart';


abstract class CartItemRepo{
  Either<Failure, Cart> getCartItems();
  Future<Either<Failure, int>> addCartItem(CartItem cartItem);
  Future<Either<Failure, int>> deleteCartItem(CartItem cartItem);
  Future<Either<Failure, int?>> getQuantity(String id);
}