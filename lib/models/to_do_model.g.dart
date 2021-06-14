// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoModelAdapter extends TypeAdapter<ToDoModel> {
  @override
  final int typeId = 0;

  @override
  ToDoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDoModel(
      item: fields[0] as String,
      checkValue: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ToDoModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.item)
      ..writeByte(1)
      ..write(obj.checkValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
