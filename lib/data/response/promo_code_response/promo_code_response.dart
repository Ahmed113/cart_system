import 'package:json_annotation/json_annotation.dart';
part 'promo_code_response.g.dart';

@JsonSerializable()
class PromoCodeResponse{
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'discount_percentage')
  double? discountPercentage;
  PromoCodeResponse({this.code, this.discountPercentage});

  /// fromJson
  factory PromoCodeResponse.fromJson(Map<String, dynamic> json) => _$PromoCodeResponseFromJson(json);

  /// toJson
  Map<String, dynamic> toJson() => _$PromoCodeResponseToJson(this);
}