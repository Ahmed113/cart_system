import 'package:cart_system/domain/usecase/cart_item_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/cart_item.dart';
import 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  final AddCartItemUsecase _addCartItemUsecase;
  AddToCartCubit(this._addCartItemUsecase) : super(AddToCartInitState());
  Future<void> addToCart(CartItem cartItem) async {
    emit(AddToCartLoadingState(id: cartItem.id));
    (await _addCartItemUsecase.addCartItem(cartItem)).fold(
      (failure) => emit(AddToCartFailedState(message: failure.message)),
      (quantity) {
        emit(AddToCartSuccessState(itemCount: quantity, id: cartItem.id));
      },
    );
  }
}
