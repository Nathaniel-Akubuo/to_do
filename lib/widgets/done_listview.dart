import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/util/to_do.dart';
import 'to_do_bubble.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/widgets/modal_bottom_sheet.dart';

class DoneListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ToDo>(
      builder: (context, child, toDo) {
        var toDo = Provider.of<ToDo>(context, listen: false);
        return Container(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ToDoBubble(
                isDone: true,
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: kBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      context: context,
                      builder: (context) => ModalBottomSheet(
                            defaultText: toDo.doneList[index].item,
                            type: 'homeDone',
                            index: index,
                          ));
                },
                keyValue: toDo.doneList[index].item,
                onDismissed: (d) => toDo.dismissDone(
                    direction: DismissDirection.startToEnd, index: index),
                title: toDo.doneList[index].item,
                isChecked: toDo.doneList[index].checkValue,
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
