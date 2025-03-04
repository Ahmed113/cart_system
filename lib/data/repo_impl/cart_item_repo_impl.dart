import 'package:cart_system/app/failure.dart';
import 'package:cart_system/data/data_source/cart_local__data_source.dart';
import 'package:cart_system/data/mappers/mapper.dart';
import 'package:cart_system/domain/repo/cart_item_repo.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entity/cart.dart';
import '../../domain/entity/cart_item.dart';
import '../response/cart_item_response/cart_item_response.dart';

class CartItemRepoImpl implements CartItemRepo{
  final CartLocalDataSource _cartLocalDataSource;
  CartItemRepoImpl(this._cartLocalDataSource);
  
  @override
  Future<Either<Failure, int>> addCartItem(CartItem cartItem) async {
    try{
      List<CartItemResponse> items = _cartLocalDataSource.getCartItems();
      // bool isInCart = false;
      int quantity = 0;
      for(int i = 0; i< items.length; i++){
        if (items[i].id == cartItem.id) {
          items[i].quantity = items[i].quantity! +1;
          _cartLocalDataSource.updateCartItem(i, items[i]);
          // isInCart = true;
          quantity = items[i].quantity!;
          break;
        }
      }
      if (quantity == 0) {
        quantity = 1;
        _cartLocalDataSource.addCartItem(cartItem.fromDomain());
      }
      return Right(quantity);
    } catch (e){
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, int>> deleteCartItem(CartItem cartItem) async{
    try{
      int quantity = 0;
      List<CartItemResponse> items = _cartLocalDataSource.getCartItems();
      for(int i =0; i< items.length; i++){
        if (items[i].id == cartItem.id) {
          if (items[i].quantity! > 1) {
            items[i].quantity = items[i].quantity! -1;
            await _cartLocalDataSource.updateCartItem(i, items[i]);
            quantity = items[i].quantity!;
            break;
          }else{
            // quantity = 0;
            await _cartLocalDataSource.deleteCartItem(i);
            break;
          }
        }
      }
      return Right(quantity);
    } catch (e){
      return Left(LocalStorageFailure(message: e.runtimeType.toString()));
    }
  }

  @override
  Either<Failure, Cart> getCartItems() {
    try{
      List<CartItemResponse> cartItemResponse = _cartLocalDataSource.getCartItems();
      List<CartItem> cartItems = cartItemResponse.map((item) => item.toDomain()).toList();
      return Right(Cart(cartItems: cartItems));
    } catch (e){
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int?>> getQuantity(String id) async{
    try{
      return Right(await _cartLocalDataSource.getQuantity(id));
    } catch (e){
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }
}