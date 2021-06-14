import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/constants/themes.dart';
import 'package:to_do/models/to_do_model.dart';
import 'package:to_do/util/hive_database.dart';
import 'package:to_do/widgets/grey_rounded_button.dart';
import 'package:to_do/widgets/modal_bottom_sheet.dart';
import 'package:hive/hive.dart';
import 'package:to_do/widgets/to_do_bubble.dart';

class GroupScreen extends StatefulWidget {
  final title;

  GroupScreen({this.title});

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  void openBox() async {
    await Hive.openBox('${widget.title}undone');
    await Hive.openBox('${widget.title}done');
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<HiveDatabase>(context, listen: true).title = widget.title;
    var primaryColor = Theme.of(context).primaryColor;
    openBox();
    return SafeArea(
      child: Consumer<HiveDatabase>(
        builder: (context, child, groupToDo) {
          var groupToDo = Provider.of<HiveDatabase>(context, listen: true);
          return Scaffold(
            backgroundColor: primaryColor,
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: Text(widget.title),
              centerTitle: true,
              elevation: 0,
            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: kBlue,
                child: Icon(Icons.add),
                onPressed: () => showModalBottomSheet(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      context: context,
                      builder: (context) => ModalBottomSheet(
                        type: 'groupScreenAdd',
                        keyValue: widget.title,
                      ),
                    )),
            body: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      GreyRoundedButton(
                        title: (groupToDo.undoneListLength == 1)
                            ? 'You have ${groupToDo.undoneListLength} undone task'
                            : 'You have ${groupToDo.undoneListLength} undone tasks',
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    flex: 3,
                    child: _buildUndoneListView(context),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      GreyRoundedButton(
                        title: (groupToDo.doneListLength == 0)
                            ? 'You have completed ${groupToDo.doneListLength} tasks'
                            : (groupToDo.doneListLength == 1)
                                ? 'Hurray! You have completed ${groupToDo.doneListLength} task'
                                : 'Hurray! You have completed ${groupToDo.doneListLength} tasks',
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    flex: 2,
                    child: _buildDoneListView(context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUndoneListView(BuildContext context) {
    return Consumer<HiveDatabase>(builder: (context, child, groupToDo) {
      var groupToDo = Provider.of<HiveDatabase>(context, listen: true);
      return ListView.builder(
        itemBuilder: (context, index) {
          var toDo =
              Hive.box('${widget.title}undone').getAt(index) as ToDoModel;
          return ToDoBubble(
            isDone: false,
            title: toDo.item,
            isChecked: toDo.checkValue,
            keyValue: toDo.item,
            onChecked: (v) => groupToDo.markAsDone(value: v, index: index),
            onDismissed: (d) => groupToDo.dismissUndone(
                index: index, direction: DismissDirection.startToEnd),
            onTap: () => showModalBottomSheet(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                context: context,
                builder: (context) => ModalBottomSheet(
                      defaultText: toDo.item,
                      type: 'groupUndone',
                      index: index,
                      keyValue: groupToDo.title,
                    )),
          );
        },
        itemCount: Hive.box('${widget.title}undone').length,
      );
    });
  }

  Widget _buildDoneListView(BuildContext context) {
    return Consumer<HiveDatabase>(builder: (context, child, groupToDo) {
      var groupToDo = Provider.of<HiveDatabase>(context, listen: true);
      return ListView.builder(
        itemBuilder: (context, index) {
          var toDo = Hive.box('${widget.title}done').getAt(index) as ToDoModel;
          return ToDoBubble(
            isDone: true,
            title: toDo.item,
            isChecked: toDo.checkValue,
            keyValue: toDo.item,
            onChecked: (v) {
              groupToDo.markAsUndone(value: v, index: index);
            },
            onDismissed: (d) {
              groupToDo.dismissDone(
                  index: index, direction: DismissDirection.startToEnd);
            },
            onTap: () => showModalBottomSheet(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                context: context,
                builder: (context) => ModalBottomSheet(
                      defaultText: toDo.item,
                      type: 'groupDone',
                      index: index,
                      keyValue: widget.title,
                    )),
          );
        },
        itemCount: Hive.box('${widget.title}done').length,
      );
    });
  }
}
