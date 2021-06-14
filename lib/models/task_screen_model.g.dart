// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_screen_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskScreenModelAdapter extends TypeAdapter<TaskScreenModel> {
  @override
  final int typeId = 1;

  @override
  TaskScreenModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskScreenModel(
      name: fields[0] as dynamic,
      dateCreated: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TaskScreenModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.dateCreated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskScreenModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
