
import '../../../../../domain/entity/cart_item.dart';

abstract class GetCartState{}
class GetCartInitState extends GetCartState{}
class GetCartLoadingState extends GetCartState{}
class GetCartSuccessState extends GetCartState{
  List<CartItem> cartItems;
  double totalPrice;
  int totalItems;
  GetCartSuccessState({required this.cartItems, required this.totalPrice, required this.totalItems});
}
class GetCartFailedState extends GetCartState{
  final String message;

  GetCartFailedState({required this.message});
}