import 'package:cart_system/domain/usecase/promo_code_usecase.dart';
import 'package:cart_system/presentation/pages/checkout/cubit/promo_code_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PromoCodeCubit extends Cubit<PromoCodeState>{
  final PromoCodeUsecase _promoCodeUsecase;
  PromoCodeCubit(this._promoCodeUsecase) : super(PromoCodeInitState());

  Future<void> getDiscount(String code, double totalPrice)async{
    emit(PromoCodeLoadingState());
    (await _promoCodeUsecase.getDiscount(code, totalPrice)).fold(
        (failure) => emit(PromoCodeFailedState(message: failure.message)),
        (priceAfterDiscount) => emit(PromoCodeSuccessState(priceAfterDiscount: priceAfterDiscount))
    );
  }
}