import "package:hive/hive.dart";
import "package:json_annotation/json_annotation.dart";
part 'product_response.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class ProductResponse extends HiveObject{
  @JsonKey(name: 'id')
  @HiveField(0)
  String? id;
  @JsonKey(name: 'title')
  @HiveField(1)
  String? name;
  @JsonKey(name: 'description')
  @HiveField(2)
  String? description;
  @JsonKey(name: 'price')
  @HiveField(3)
  double? price;
  @JsonKey(name: 'image')
  @HiveField(4)
  String? imageUrl;

  ProductResponse({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
  });

  /// fromJson
  factory ProductResponse.fromJson(Map<String, dynamic> json) => _$ProductResponseFromJson(json);

  /// toJson
  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}
