import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/models/to_do_model.dart';

class GroupToDo extends ChangeNotifier {
  SharedPreferences prefs;
  List<ToDoModel> undoneList = [];
  List<ToDoModel> doneList = [];
  String title;

  initPrefs(key) async {
    prefs = await SharedPreferences.getInstance();
    loadUndoneData(key: key);
    loadDoneData(key: key);
    notifyListeners();
  }

  double percentDone({key}) {
    var undone = prefs.getStringList("${key}undone");
    var done = prefs.getStringList("${key}done");
    var percent;
    if (undone != null && done != null) {
      percent = (done.length / (done.length + undone.length));
      return percent;
    } else
      return 0;
  }

  void initPercent(key) async {
    prefs = await SharedPreferences.getInstance();
    percentDone(key: key);
    notifyListeners();
  }

  int get doneCount => doneList.length;

  int get totalCount => doneList.length + undoneList.length;

  void saveUndoneData({key}) {
    var list = undoneList.map((e) => jsonEncode(e.toMap())).toList();
    prefs.setStringList("${key}undone", list);
    notifyListeners();
  }

  void loadUndoneData({key}) {
    var list = prefs.getStringList("${key}undone");
    undoneList = [];
    if (list != null) {
      undoneList = list.map((e) => ToDoModel.fromMap(jsonDecode(e))).toList();
      notifyListeners();
    }
  }

  void saveDoneData({key}) {
    var done = doneList.map((e) => jsonEncode(e.toMap())).toList();
    prefs.setStringList("${key}done", done);
    notifyListeners();
  }

  void loadDoneData({key}) {
    var list = prefs.getStringList("${key}done");
    doneList = [];
    if (list != null) {
      doneList = list.map((e) => ToDoModel.fromMap(jsonDecode(e))).toList();
      notifyListeners();
    }
  }

  void add({text, key}) {
    title = key;
    var toDoModel = ToDoModel(item: text, checkValue: false);
    undoneList.add(toDoModel);
    saveUndoneData(key: key);
    notifyListeners();
  }

  void editUndoneToDo({String item, int index, key}) {
    undoneList[index].item = item;
    saveUndoneData(key: key);
    notifyListeners();
  }

  void editDoneToDo({String item, int index, key}) {
    doneList[index].item = item;
    saveDoneData(key: key);
    notifyListeners();
  }

  void markAsDone({bool value, int index, key}) {
    undoneList[index].checkValue = !undoneList[index].checkValue;
    doneList.add(undoneList[index]);
    undoneList.removeAt(index);
    saveUndoneData(key: key);
    saveDoneData(key: key);
    notifyListeners();
  }

  void markAsUndone({bool value, int index, key}) {
    doneList[index].checkValue = !doneList[index].checkValue;
    undoneList.add(doneList[index]);
    doneList.removeAt(index);
    saveUndoneData(key: key);
    saveDoneData(key: key);
    notifyListeners();
  }

  void dismissUndone({DismissDirection direction, int index, key}) {
    if (direction == DismissDirection.startToEnd) {
      undoneList.removeAt(index);
      saveUndoneData(key: key);
      notifyListeners();
    }
  }

  void dismissDone({DismissDirection direction, int index, key}) {
    if (direction == DismissDirection.startToEnd) {
      doneList.removeAt(index);
      saveDoneData(key: key);
      notifyListeners();
    }
  }
}
