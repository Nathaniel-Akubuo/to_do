import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/util/group_to_do.dart';
import 'package:to_do/widgets/modal_bottom_sheet.dart';
import 'package:to_do/widgets/to_do_bubble.dart';

class GroupUndoneListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupToDo>(builder: (context, child, groupToDo) {
      var groupToDo = Provider.of<GroupToDo>(context, listen: false);
      return ListView.builder(
        itemBuilder: (context, index) {
          return ToDoBubble(
            isDone: false,
            title: groupToDo.undoneList[index].item,
            isChecked: groupToDo.undoneList[index].checkValue,
            keyValue: groupToDo.undoneList[index].item,
            onChecked: (v) => groupToDo.markAsDone(
                value: v, index: index, key: groupToDo.title),
            onDismissed: (d) => groupToDo.dismissUndone(
                index: index,
                direction: DismissDirection.startToEnd,
                key: groupToDo.title),
            onTap: () => showModalBottomSheet(
                backgroundColor: kBackgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                context: context,
                builder: (context) => ModalBottomSheet(
                      defaultText: groupToDo.undoneList[index].item,
                      type: 'groupUndone',
                      index: index,
                      keyValue: groupToDo.title,
                    )),
          );
        },
        itemCount: groupToDo.undoneList.length,
      );
    });
  }
}
