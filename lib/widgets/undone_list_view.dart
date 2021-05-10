import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/util/to_do.dart';
import 'to_do_bubble.dart';

class UndoneListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ToDo>(
      builder: (context, child, toDo) {
        var toDo = Provider.of<ToDo>(context, listen: false);
        return Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ToDoBubble(
                keyValue: toDo.undoneList[index].item,
                onDismissed: (d) => toDo.dismissUndone(
                    index: index, direction: DismissDirection.startToEnd),
                title: toDo.undoneList[index].item,
                isChecked: toDo.undoneList[index].isChecked,
                onChecked: (v) => toDo.markAsDone(value: v, index: index),
              );
            },
            itemCount: toDo.undoneList.length,
          ),
        );
      },
    );
  }
}
