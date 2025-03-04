import 'package:cart_system/domain/repo/cart_item_repo.dart';
import 'package:dartz/dartz.dart';

import '../../app/failure.dart';
import '../entity/cart.dart';
import '../entity/cart_item.dart';

class AddCartItemUsecase{
  final CartItemRepo _cartItemRepo;
  AddCartItemUsecase(this._cartItemRepo);

  Future<Either<Failure, int>> addCartItem(CartItem cartItem) async {
    return await _cartItemRepo.addCartItem(cartItem);
  }
}

class DeleteCartItemUsecase{
  final CartItemRepo _cartItemRepo;
  DeleteCartItemUsecase(this._cartItemRepo);

  Future<Either<Failure, int>> deleteCartItem(CartItem cartItem) async{
    return await _cartItemRepo.deleteCartItem(cartItem);
  }
}

class GetAllCartItemsUsecase{
  final CartItemRepo _cartItemRepo;
  GetAllCartItemsUsecase(this._cartItemRepo);

  Either<Failure, Cart> getCartItems() {
    return _cartItemRepo.getCartItems();
  }
}

class GetQuantityCartItemUsecase{
  final CartItemRepo _cartItemRepo;
  GetQuantityCartItemUsecase(this._cartItemRepo);

  Future<Either<Failure, int?>> getQuantity(String id) async{
    return await _cartItemRepo.getQuantity(id);
  }
}
