import 'package:cart_system/app/extensions/extensions.dart';
import 'package:cart_system/domain/usecase/cart_item_usecases.dart';
import 'package:cart_system/presentation/pages/cart/cubit/get_cart/get_cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'get_quantity_state.dart';

class GetQuantityCubit extends Cubit<GetQuantityState>{
  final GetQuantityCartItemUsecase _getQuantityCartItemUsecase;
  GetQuantityCubit(this._getQuantityCartItemUsecase) : super(GetQuantityInitState());

  Future<void> getQuantity(String id) async{
    // emit(GetQuantityLoadingState());
    (await _getQuantityCartItemUsecase.getQuantity(id)).fold(
        (failure) => emit(GetQuantityFailedState(message: failure.message)),
        (itemCount) => emit(GetQuantitySuccessState(id: id, itemCount: itemCount.orZero()))
    );
  }
}