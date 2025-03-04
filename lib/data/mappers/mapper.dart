import 'package:cart_system/app/extensions/extensions.dart';
import 'package:cart_system/data/response/cart_item_response/cart_item_response.dart';
import 'package:cart_system/data/response/product_response/product_response.dart';
import 'package:cart_system/data/response/promo_code_response/promo_code_response.dart';
import 'package:cart_system/domain/entity/promo_code.dart';

import '../../domain/entity/cart_item.dart';
import '../../domain/entity/product.dart';


extension ProductResponseMapper on ProductResponse {
  Product toDomain() {
    return Product(
      id: id.orEmpty(),
      name: name.orEmpty(),
      description: description.orEmpty(),
      price: price.orZero(),
      imageUrl: imageUrl.orEmpty(),
    );
  }
}

extension ProductMapper on Product {
  ProductResponse fromDomain() {
    return ProductResponse(
      id: id.orEmpty(),
      name: name.orEmpty(),
      description: description.orEmpty(),
      price: price.orZero(),
      imageUrl: imageUrl.orEmpty(),
    );
  }
}

extension CartItemResponseMapper on CartItemResponse {
  CartItem toDomain(){
    ProductResponse product = this.product.orEmpty();
    return CartItem(
        id: id.orEmpty(),
        product: product.toDomain(),
        quantity: quantity ?? 1,
    );
  }
}

extension CartItemMapper on CartItem {
  CartItemResponse fromDomain(){
    return CartItemResponse(
      id: id.orEmpty(),
      product: product.fromDomain(),
      quantity: quantity,
    );
  }
}

extension CastProductToCartItem on Product {
  CartItem toCartItem() {
    return CartItem(id: id, product: this, quantity: 1);
  }
}

extension PromoCodeMapper on PromoCode{
  PromoCodeResponse fromDomain(){
    return PromoCodeResponse(
      code: code,
      discountPercentage: discountPercentage
    );
  }
}

extension PromoCodeResponseMapper on PromoCodeResponse{
  PromoCode toDomain() {
    return PromoCode(
        code: code.orEmpty(),
        discountPercentage: discountPercentage.orZero()
    );
  }
}