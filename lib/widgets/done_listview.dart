import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/to_do_model.dart';
import 'package:to_do/util/to_do.dart';
import 'to_do_bubble.dart';
import 'package:to_do/widgets/modal_bottom_sheet.dart';

class DoneListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var doneBox = Hive.box('done');
    return Consumer<ToDo>(
      builder: (context, child, toDo) {
        var toDo = Provider.of<ToDo>(context, listen: false);
        return Container(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var currentItem = doneBox.getAt(index) as ToDoModel;
              return ToDoBubble(
                isDone: true,
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    context: context,
                    builder: (context) => ModalBottomSheet(
                      defaultText: currentItem.item,
                      type: 'homeDone',
                      index: index,
                    ),
                  );
                },
                keyValue: currentItem.item,
                onDismissed: (d) => toDo.dismissDone(
                    direction: DismissDirection.startToEnd, index: index),
                title: currentItem.item,
                isChecked: currentItem.checkValue,
                onChecked: (v) => toDo.markAsUndone(value: v, index: index),
              );
            },
            itemCount: doneBox.length,
          ),
        );
      },
    );
  }
}
