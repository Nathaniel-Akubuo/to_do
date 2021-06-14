import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/models/task_screen_model.dart';
import 'package:to_do/models/to_do_model.dart';

class ToDo extends ChangeNotifier {

  void addGroup(name) {
    Hive.openBox('group');
    var group = TaskScreenModel(
        name: name,
        dateCreated:
            '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}');
    Hive.box('group').add(group);
    notifyListeners();
  }

  void deleteGroup({index}) {
    Hive.box('group').deleteAt(index);
    notifyListeners();
  }

  double percentDone() {
    var undone = Hive.box('undone');
    var done = Hive.box("done");
    var percent;
    if (undone != null && done != null) {
      percent = (done.length / (done.length + undone.length));
      return percent;
    } else
      return 0;
  }

  void addToDo(String item) {
    Hive.openBox('undone');
    var toDoItem = ToDoModel(item: item, checkValue: false);
    Hive.box('undone').add(toDoItem);
    notifyListeners();
  }

  void editUndoneToDo(String item, int index) {
    var undoneBox = Hive.box('undone');
    var todo = undoneBox.getAt(index) as ToDoModel;
    todo.item = item;
    notifyListeners();
  }

  void editDoneToDo(String item, int index) {
    var doneBox = Hive.box('done');
    var todo = doneBox.getAt(index) as ToDoModel;
    todo.item = item;
    notifyListeners();
  }

  void markAsDone({bool value, int index}) {
    var undoneBox = Hive.box('undone');
    var doneBox = Hive.box('done');
    var todo = undoneBox.getAt(index) as ToDoModel;
    todo.checkValue = !todo.checkValue;
    doneBox.add(todo);
    undoneBox.deleteAt(index);
    notifyListeners();
  }

  void markAsUndone({bool value, int index}) {
    var undoneBox = Hive.box('undone');
    var doneBox = Hive.box('done');
    var todo = doneBox.getAt(index) as ToDoModel;
    todo.checkValue = !todo.checkValue;
    undoneBox.add(todo);
    doneBox.deleteAt(index);
    notifyListeners();
  }

  void dismissUndone({DismissDirection direction, int index}) {
    var undoneBox = Hive.box('undone');
    if (direction == DismissDirection.startToEnd) {
      undoneBox.deleteAt(index);
      notifyListeners();
    }
  }

  void dismissDone({DismissDirection direction, int index}) {
    var doneBox = Hive.box('done');
    if (direction == DismissDirection.startToEnd) {
      doneBox.deleteAt(index);
      notifyListeners();
    }
  }
}
