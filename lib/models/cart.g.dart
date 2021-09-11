// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartDBAdapter extends TypeAdapter<CartDB> {
  @override
  final int typeId = 0;

  @override
  CartDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartDB()
      ..productId = fields[0] as int
      ..qty = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, CartDB obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.qty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
