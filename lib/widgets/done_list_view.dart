import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/util/to_do.dart';
import 'to_do_bubble.dart';

class DoneListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ToDo>(
      builder: (context, child, toDo) {
        var toDo = Provider.of<ToDo>(context, listen: false);
        return Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ToDoBubble(
                keyValue: toDo.doneList[index].item,
                onDismissed: (d) => toDo.dismissDone(
                    direction: DismissDirection.startToEnd, index: index),
                title: toDo.doneList[index].item,
                isChecked: toDo.doneList[index].isChecked,
                onChecked: (v) => toDo.markAsUndone(value: v, index: index),
              );
            },
            itemCount: toDo.doneList.length,
          ),
        );
      },
    );
  }
}
