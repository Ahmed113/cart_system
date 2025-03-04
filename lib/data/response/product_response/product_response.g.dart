// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductResponseAdapter extends TypeAdapter<ProductResponse> {
  @override
  final int typeId = 1;

  @override
  ProductResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductResponse(
      id: fields[0] as String?,
      name: fields[1] as String?,
      description: fields[2] as String?,
      price: fields[3] as double?,
      imageUrl: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductResponse obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      id: json['id'] as String?,
      name: json['title'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      imageUrl: json['image'] as String?,
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.name,
      'description': instance.description,
      'price': instance.price,
      'image': instance.imageUrl,
    };
