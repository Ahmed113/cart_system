import 'package:cart_system/data/data_source/promo_code_local_data_source.dart';
import 'package:cart_system/data/mappers/mapper.dart';
import 'package:cart_system/data/response/promo_code_response/promo_code_response.dart';
import 'package:cart_system/domain/repo/promo_code_repo.dart';

import '../../domain/entity/promo_code.dart';

class PromoCodeRepoImpl extends PromoCodeRepo{
  final PromoCodeLocalDataSource _promoCodeLocalDataSource;
  PromoCodeRepoImpl(this._promoCodeLocalDataSource);

  @override
  Future<List<PromoCode>> getPromoCodes() async{
      List<PromoCodeResponse> promoCodeResponse = await _promoCodeLocalDataSource.getPromoCodes();
      List<PromoCode> promoCode = promoCodeResponse.map((item) => item.toDomain()).toList();
      return promoCode;
  }

}