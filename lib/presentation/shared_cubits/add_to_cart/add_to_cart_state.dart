abstract class AddToCartState{}
class AddToCartInitState extends AddToCartState{}
class AddToCartLoadingState extends AddToCartState{
  final String id;
  AddToCartLoadingState({required this.id});
}
class AddToCartSuccessState extends AddToCartState{
  final int itemCount;
  final String id;
  AddToCartSuccessState({required this.itemCount, required this.id});
}
class AddToCartFailedState extends AddToCartState{
  final String message;
  AddToCartFailedState({required this.message});
}