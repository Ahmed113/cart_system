import 'package:cart_system/domain/usecase/cart_item_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/cart_item.dart';
import 'delete_from_cart_state.dart';

class DeleteFromCartCubit extends Cubit<DeleteFromCartState>{
  final DeleteCartItemUsecase _deleteCartItemUsecase;
  DeleteFromCartCubit(this._deleteCartItemUsecase) : super(DeleteFromCartInitState());

  Future<void> deleteFromCart(CartItem cartItem) async{
    emit(DeleteFromCartLoadingState());
    (await _deleteCartItemUsecase.deleteCartItem(cartItem)).fold(
        (failure) => emit(DeleteFromCartFailedState(message: failure.message)),
        (quantity) => emit(DeleteFromCartSuccessState(itemCount: quantity, id: cartItem.id))
    );
  }
}