import 'dart:convert';

import 'package:cart_system/data/response/promo_code_response/promo_code_response.dart';
import 'package:flutter/services.dart';

import '../../presentation/resources/assets_manager.dart';

abstract class PromoCodeLocalDataSource{
  Future<List<PromoCodeResponse>> getPromoCodes();
}
const String promoCodeAttribute = 'promo_codes';
class PromoCodeLocalDataSourceImpl implements PromoCodeLocalDataSource{
  @override
  Future<List<PromoCodeResponse>> getPromoCodes() async{
    String jsonString = await rootBundle.loadString(AssetsManager.promoCodesJson);
    print(jsonString);
    Map<String, dynamic> promoCodeMap = jsonDecode(jsonString);
    List promoCodeList = promoCodeMap[promoCodeAttribute];
    List<PromoCodeResponse> promoCodes = promoCodeList.map((item) => PromoCodeResponse.fromJson(item)).toList();
    return promoCodes;
  }
}