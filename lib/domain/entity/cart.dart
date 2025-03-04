import 'package:cart_system/app/extensions/extensions.dart';

import 'cart_item.dart';

class Cart{
  List<CartItem> cartItems;
  // int wholeItemsCount;
  // double totalPrice;
  Cart({required this.cartItems});

  int get wholeItemCount => _getTotalItems(cartItems);
  double get totalPrice => _getTotalPrice(cartItems);

  double _getTotalPrice(List<CartItem> items) {
    double totalPrice = 0;
    double productPriceOnQuantity = 0;
    for (int i = 0; i < items.length; i++) {
      productPriceOnQuantity = items[i].quantity * items[i].product.price;
      totalPrice = totalPrice + productPriceOnQuantity;
    }
    return totalPrice.takeTwoDecimal();
  }

  int _getTotalItems(List<CartItem> items) {
    int totalItems = 0;
    for (int i = 0; i < items.length; i++) {
      totalItems = totalItems + items[i].quantity;
    }
    return totalItems;
  }
}