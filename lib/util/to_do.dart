import 'package:flutter/material.dart';
import 'package:to_do/models/to_do_model.dart';

class ToDo extends ChangeNotifier {
  List<ToDoModel> undoneList = [];
  List<ToDoModel> doneList = [];

  int undoneListLength() {
    var v = undoneList.length;
    notifyListeners();
    return v;
  }

  int doneListLength() {
    var v = doneList.length;
    notifyListeners();
    return v;
  }

  void addToDo(String item) {
    var toDoItem = ToDoModel(item: item, isChecked: false);
    undoneList.add(toDoItem);
    notifyListeners();
  }

  void markAsDone({bool value, int index}) {
    undoneList[index].isChecked = !undoneList[index].isChecked;
    doneList.add(undoneList[index]);
    undoneList.removeAt(index);
    notifyListeners();
  }

  void markAsUndone({bool value, int index}) {
    doneList[index].isChecked = !doneList[index].isChecked;
    undoneList.add(doneList[index]);
    doneList.removeAt(index);
    notifyListeners();
  }

  void dismissUndone({DismissDirection direction, int index}) {
    if (direction == DismissDirection.startToEnd) {
      undoneList.removeAt(index);
      notifyListeners();
    }
  }

  void dismissDone({DismissDirection direction, int index}) {
    if (direction == DismissDirection.startToEnd) {
      doneList.removeAt(index);
      notifyListeners();
    }
  }
}
