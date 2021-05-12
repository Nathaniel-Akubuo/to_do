import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:to_do/models/to_do_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDo extends ChangeNotifier {
  SharedPreferences preferences;
  List<ToDoModel> undoneList = [];
  List<ToDoModel> doneList = [];

  initPrefs() async {
    preferences = await SharedPreferences.getInstance();
    loadUndoneData();
    loadDoneData();
    notifyListeners();
  }

  void addToDo(String item) {
    var toDoItem = ToDoModel(item: item, isChecked: false);
    undoneList.add(toDoItem);
    saveUndoneData();
    notifyListeners();
  }

  void editUndoneToDo(String item, int index) {
    undoneList[index].item = item;
    saveUndoneData();
    notifyListeners();
  }

  void editDoneToDo(String item, int index) {
    doneList[index].item = item;
    saveDoneData();
    notifyListeners();
  }

  void markAsDone({bool value, int index}) {
    undoneList[index].isChecked = !undoneList[index].isChecked;
    doneList.add(undoneList[index]);
    undoneList.removeAt(index);
    saveUndoneData();
    saveDoneData();
    notifyListeners();
  }

  void markAsUndone({bool value, int index}) {
    doneList[index].isChecked = !doneList[index].isChecked;
    undoneList.add(doneList[index]);
    doneList.removeAt(index);
    saveUndoneData();
    saveDoneData();
    notifyListeners();
  }

  void dismissUndone({DismissDirection direction, int index}) {
    if (direction == DismissDirection.startToEnd) {
      undoneList.removeAt(index);
      saveUndoneData();
      notifyListeners();
    }
  }

  void dismissDone({DismissDirection direction, int index}) {
    if (direction == DismissDirection.startToEnd) {
      doneList.removeAt(index);
      saveDoneData();
      notifyListeners();
    }
  }

  void saveUndoneData() {
    var list = undoneList.map((e) => jsonEncode(e.toMap())).toList();
    preferences.setStringList("undone", list);
    notifyListeners();
  }

  void loadUndoneData() {
    var toDoList = preferences.getStringList("undone");
    undoneList = toDoList.map((e) => ToDoModel.fromMap(jsonDecode(e))).toList();
    notifyListeners();
  }

  void saveDoneData() {
    var list = doneList.map((e) => jsonEncode(e.toMap())).toList();
    preferences.setStringList("done", list);
    notifyListeners();
  }

  void loadDoneData() {
    var toDoList = preferences.getStringList("done");
    doneList = toDoList.map((e) => ToDoModel.fromMap(jsonDecode(e))).toList();
    notifyListeners();
  }
}
