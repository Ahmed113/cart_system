// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_code_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoCodeResponse _$PromoCodeResponseFromJson(Map<String, dynamic> json) =>
    PromoCodeResponse(
      code: json['code'] as String?,
      discountPercentage: (json['discount_percentage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PromoCodeResponseToJson(PromoCodeResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'discount_percentage': instance.discountPercentage,
    };
