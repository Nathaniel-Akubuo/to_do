class TaskScreenModel {
  final name;
  final String dateCreated;

  TaskScreenModel({this.name, this.dateCreated});

  TaskScreenModel.fromMap(Map map)
      : this.name = map['name'],
        this.dateCreated = map['date'];

  Map toMap() {
    return {'name': this.name, 'date': this.dateCreated};
  }
}
