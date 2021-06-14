import 'package:hive/hive.dart';
part 'task_screen_model.g.dart';

@HiveType(typeId: 1)
class TaskScreenModel {
  @HiveField(0)
  final name;
  @HiveField(1)
  final String dateCreated;

  TaskScreenModel({this.name, this.dateCreated});

  TaskScreenModel.fromMap(Map map)
      : this.name = map['name'],
        this.dateCreated = map['dateCreated'];

  Map toMap() {
    return {'name': this.name, 'dateCreated': this.dateCreated};
  }
}
