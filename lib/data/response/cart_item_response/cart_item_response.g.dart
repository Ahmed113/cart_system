// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartItemResponseAdapter extends TypeAdapter<CartItemResponse> {
  @override
  final int typeId = 0;

  @override
  CartItemResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItemResponse(
      id: fields[0] as String?,
      product: fields[1] as ProductResponse?,
      quantity: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CartItemResponse obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.product)
      ..writeByte(2)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
