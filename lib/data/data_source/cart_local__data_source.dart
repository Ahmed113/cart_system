import 'package:cart_system/data/response/cart_item_response/cart_item_response.dart';
import 'package:cart_system/presentation/resources/strings_manager.dart';
import 'package:hive/hive.dart';

abstract class CartLocalDataSource{
  List<CartItemResponse> getCartItems();
  Future<void> addCartItem(CartItemResponse cartItemResponse);
  Future<void> deleteCartItem(int index);
  Future<void> updateCartItem(int index, CartItemResponse cartItemResponse);
  Future<int?> getQuantity(String id);
}

class CartLocalDataSourceImpl implements CartLocalDataSource{
  final Box<CartItemResponse> _cartBox = Hive.box<CartItemResponse>(StringsManager.cartHiveBox);

  @override
  Future<void> addCartItem(CartItemResponse cartItemResponse) async{
    await _cartBox.add(cartItemResponse);
  }

  @override
  Future<void> deleteCartItem(int index) async {
    await _cartBox.deleteAt(index);
  }

  @override
  List<CartItemResponse> getCartItems() {
    List<CartItemResponse> cartItemResponse = _cartBox.values.toList();
    return cartItemResponse;
  }

  @override
  Future<void> updateCartItem(int index, CartItemResponse cartItemResponse) async {
    await _cartBox.putAt(index, cartItemResponse);
  }

  @override
  Future<int?> getQuantity(String id) async{
    List<CartItemResponse> cartItemsResponse = getCartItems();
    for(int i = 0; i< cartItemsResponse.length; i++){
      if (cartItemsResponse[i].id == id) {
        return cartItemsResponse[i].quantity;
      }
    }
    return null;
  }
}