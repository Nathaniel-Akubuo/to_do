import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/to_do_model.dart';
import 'package:to_do/util/to_do.dart';
import 'to_do_bubble.dart';
import 'package:to_do/widgets/modal_bottom_sheet.dart';

class UndoneListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var undoneBox = Hive.box('undone');
    return Consumer<ToDo>(
      builder: (context, child, toDo) {
        var toDo = Provider.of<ToDo>(context, listen: true);
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var currentItem = undoneBox.getAt(index) as ToDoModel;
            return ToDoBubble(
              isDone: false,
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    context: context,
                    builder: (context) => ModalBottomSheet(
                          defaultText: currentItem.item,
                          type: 'homeUndone',
                          index: index,
                        ));
              },
              keyValue: currentItem.item,
              onDismissed: (d) => toDo.dismissUndone(
                  index: index, direction: DismissDirection.startToEnd),
              title: currentItem.item,
              isChecked: currentItem.checkValue,
              onChecked: (v) => toDo.markAsDone(index: index),
            );
          },
          itemCount: undoneBox.length,
        );
      },
    );
  }
}
