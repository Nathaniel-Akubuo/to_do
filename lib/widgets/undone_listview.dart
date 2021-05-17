import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/util/to_do.dart';
import 'to_do_bubble.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/widgets/modal_bottom_sheet.dart';

class UndoneListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ToDo>(
      builder: (context, child, toDo) {
        var toDo = Provider.of<ToDo>(context, listen: true);
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ToDoBubble(
              isDone: false,
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: kBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),

                    ),
                    context: context,
                    builder: (context) => ModalBottomSheet(
                          defaultText: toDo.undoneList[index].item,
                          type: 'homeUndone',
                          index: index,
                        ));
              },
              keyValue: toDo.undoneList[index].item,
              onDismissed: (d) => toDo.dismissUndone(
                  index: index, direction: DismissDirection.startToEnd),
              title: toDo.undoneList[index].item,
              isChecked: toDo.undoneList[index].checkValue,
              onChecked: (v) => toDo.markAsDone(index: index),
            );
          },
          itemCount: toDo.undoneList.length,
        );
      },
    );
  }
}
