import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/models/to_do_model.dart';

class HiveDatabase extends ChangeNotifier {
  String title;

  Future<void> openBox(key) async {
    await Hive.openBox('${key}undone');
    await Hive.openBox('${key}done');
    notifyListeners();
  }

  double percentDone({key}) {
    var undone = Hive.box('${key}undone');
    var done = Hive.box("${key}done");
    if (undone.length != null && done.length != null) {
      if (done.length == 0) {
        return 0;
      } else {
        var percent = (done.length / (done.length + undone.length));
        return percent;
      }
    } else
      return 0;
  }

  int get undoneListLength {
    var length = Hive.box('${title}undone').length;
    return length;
  }

  int get doneListLength {
    var length = Hive.box('${title}done').length;
    return length;
  }

  void add({text}) {
    var box = Hive.box('${title}undone');
    if (box.isOpen) {
      var toDoModel = ToDoModel(item: text, checkValue: false);
      Hive.box('${title}undone').add(toDoModel);
    }
    notifyListeners();
  }

  void markAsDone({bool value, int index}) {
    var undoneBox = Hive.box('${title}undone');
    var doneBox = Hive.box('${title}done');
    var todo = undoneBox.getAt(index) as ToDoModel;
    todo.checkValue = !todo.checkValue;
    doneBox.add(todo);
    undoneBox.deleteAt(index);
    notifyListeners();
  }

  void markAsUndone({bool value, int index}) {
    var undoneBox = Hive.box('${title}undone');
    var doneBox = Hive.box('${title}done');
    var todo = doneBox.getAt(index) as ToDoModel;
    todo.checkValue = !todo.checkValue;
    undoneBox.add(todo);
    doneBox.deleteAt(index);
    notifyListeners();
  }

  void dismissUndone({DismissDirection direction, int index}) {
    var undoneBox = Hive.box('${title}undone');
    if (direction == DismissDirection.startToEnd) {
      undoneBox.deleteAt(index);
      notifyListeners();
    }
  }

  void dismissDone({DismissDirection direction, int index}) {
    var doneBox = Hive.box('${title}done');
    if (direction == DismissDirection.startToEnd) {
      doneBox.deleteAt(index);
      notifyListeners();
    }
  }

  void editUndoneToDo({String item, int index}) {
    var undoneBox = Hive.box('${title}undone');
    var value = ToDoModel(item: item, checkValue: false);
    undoneBox.putAt(index, value);
    notifyListeners();
  }

  void editDoneToDo({String item, int index}) {
    var doneBox = Hive.box('${title}done');
    var value = ToDoModel(item: item, checkValue: true);
    doneBox.putAt(index, value);
    notifyListeners();
  }
}
