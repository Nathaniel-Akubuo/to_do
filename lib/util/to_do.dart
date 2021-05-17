import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:to_do/models/task_screen_model.dart';
import 'package:to_do/models/to_do_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDo extends ChangeNotifier {
  SharedPreferences preferences;
  List<ToDoModel> undoneList = [];
  List<ToDoModel> doneList = [];
  List<TaskScreenModel> groupList = [];

  initPrefs() async {
    preferences = await SharedPreferences.getInstance();
    loadUndoneData();
    loadDoneData();
    loadGroupData();
    notifyListeners();
  }

  int getDoneCount() {
    return undoneList.length;
  }

  int get totalCount => doneList.length + undoneList.length;

  void addNewGroup(String name) {
    var group = TaskScreenModel(
        name: name,
        dateCreated:
            '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}');
    groupList.add(group);
    saveGroupData();
    notifyListeners();
  }

  double percentDone() {
    var percent;
    if (undoneList != null && doneList != null) {
      percent = (doneList.length / (doneList.length + undoneList.length));
      return percent;
    } else
      return 0;
  }

  void addToDo(String item) {
    var toDoItem = ToDoModel(item: item, checkValue: false);
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

  void markAsDone({int index}) {
    undoneList[index].checkValue = !undoneList[index].checkValue;
    doneList.add(undoneList[index]);
    undoneList.removeAt(index);
    saveDoneData();
    saveUndoneData();
    notifyListeners();
  }

  void markAsUndone({bool value, int index}) {
    doneList[index].checkValue = !doneList[index].checkValue;
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

  void deleteGroup({index}) {
    groupList.removeAt(index);
    saveGroupData();
    notifyListeners();
  }

  void saveUndoneData() {
    var list = undoneList.map((e) => jsonEncode(e.toMap())).toList();
    preferences.setStringList("undone", list);
    notifyListeners();
  }

  void saveDoneData() {
    var list = doneList.map((e) => jsonEncode(e.toMap())).toList();
    preferences.setStringList("done", list);
    notifyListeners();
  }

  void saveGroupData() {
    var list = groupList.map((e) => jsonEncode(e.toMap())).toList();
    preferences.setStringList("group", list);
    notifyListeners();
  }

  void loadUndoneData() {
    var toDoList = preferences.getStringList("undone");
    if (toDoList != null) {
      undoneList =
          toDoList.map((e) => ToDoModel.fromMap(jsonDecode(e))).toList();
      notifyListeners();
    }
  }

  void loadDoneData() {
    var toDoList = preferences.getStringList("done");
    if (toDoList != null) {
      doneList = toDoList.map((e) => ToDoModel.fromMap(jsonDecode(e))).toList();
      notifyListeners();
    }
  }

  void loadGroupData() {
    var groupData = preferences.getStringList("group");
    if (groupData != null) {
      groupList =
          groupData.map((e) => TaskScreenModel.fromMap(jsonDecode(e))).toList();
      notifyListeners();
    }
  }
}
