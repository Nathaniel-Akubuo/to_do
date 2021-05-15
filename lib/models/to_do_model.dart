class ToDoModel {
  String item;
  bool checkValue = false;

  ToDoModel({this.item, this.checkValue});

  ToDoModel.fromMap(Map map)
      : this.item = map['item'],
        this.checkValue = map['isChecked'];

  Map toMap() {
    return {'item': this.item, 'isChecked': this.checkValue};
  }
}
