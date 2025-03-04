import 'package:cart_system/domain/usecase/cart_item_usecases.dart';
import 'package:cart_system/presentation/pages/cart/cubit/get_cart/get_cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetCartCubit extends Cubit<GetCartState> {
  final GetAllCartItemsUsecase _getAllCartItemsUsecase;

  GetCartCubit(this._getAllCartItemsUsecase) : super(GetCartInitState());

  Future<void> getCartItems() async{
    emit(GetCartLoadingState());
    _getAllCartItemsUsecase.getCartItems().fold(
      (failure) => emit(GetCartFailedState(message: failure.message)),
      (cart) => emit(GetCartSuccessState(cartItems: cart.cartItems, totalPrice: cart.totalPrice, totalItems: cart.wholeItemCount)),
    );
  }
}
