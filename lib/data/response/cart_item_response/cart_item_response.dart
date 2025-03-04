import 'package:cart_system/data/response/product_response/product_response.dart';
import 'package:hive/hive.dart';

part 'cart_item_response.g.dart';

@HiveType(typeId: 0)
class CartItemResponse extends HiveObject{
  @HiveField(0)
  String? id;
  @HiveField(1)
  ProductResponse? product;
  @HiveField(2)
  int? quantity;

  CartItemResponse({
    this.id,
    this.product,
    this.quantity = 1,
  });
}