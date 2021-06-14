import 'package:hive/hive.dart';
part 'to_do_model.g.dart';

@HiveType(typeId: 0)
class ToDoModel {
  @HiveField(0)
  String item;

  @HiveField(1)
  bool checkValue = false;

  ToDoModel({this.item, this.checkValue});

  ToDoModel.fromMap(Map map)
      : this.item = map['item'],
        this.checkValue = map['isChecked'];

  Map toMap() {
    return {'item': this.item, 'isChecked': this.checkValue};
  }
}
