import 'package:cart_system/data/response/product_response/product_response.dart';

extension NonNullString  on String? {
  orEmpty() {
    return this ?? '';
  }
}

extension NonNullDouble  on double? {
  orZero() {
    return this ?? 0;
  }
}

extension RoundDouble  on double {
  takeTwoDecimal() {
    return double.parse(toStringAsFixed(2));
  }
}

extension NonNullInt  on int? {
  orZero() {
    return this ?? 0;
  }
}

extension NonNullProductResponse on ProductResponse? {
  orEmpty() {
    return this ?? ProductResponse(id: '', name: '', description: '', imageUrl: '', price: 0);
  }
}