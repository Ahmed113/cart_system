import '../entity/promo_code.dart';

abstract class PromoCodeRepo{
  Future<List<PromoCode>> getPromoCodes();
}