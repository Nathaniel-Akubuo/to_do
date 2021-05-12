class ToDoModel {
  String item;
  bool isChecked = false;

  ToDoModel({this.item, this.isChecked});

  ToDoModel.fromMap(Map map)
      : this.item = map['item'],
        this.isChecked = map['isChecked'];

  Map toMap() {
    return {'item': this.item, 'isChecked': this.isChecked};
  }
}
