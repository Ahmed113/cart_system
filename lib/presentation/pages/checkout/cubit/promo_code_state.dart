abstract class PromoCodeState{}
class PromoCodeInitState extends PromoCodeState{}
class PromoCodeLoadingState extends PromoCodeState{}
class PromoCodeSuccessState extends PromoCodeState{
  final double priceAfterDiscount;
  PromoCodeSuccessState({required this.priceAfterDiscount});
}
class PromoCodeFailedState extends PromoCodeState{
  final String message;
  PromoCodeFailedState({required this.message});
}
