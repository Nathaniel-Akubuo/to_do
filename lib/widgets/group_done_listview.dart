import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/util/group_to_do.dart';
import 'package:to_do/widgets/to_do_bubble.dart';
import 'modal_bottom_sheet.dart';

class GroupDoneListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupToDo>(builder: (context, child, groupToDo) {
      var groupToDo = Provider.of<GroupToDo>(context, listen: false);
      return ListView.builder(
        itemBuilder: (context, index) {
          return ToDoBubble(
            title: groupToDo.doneList[index].item,
            isChecked: groupToDo.doneList[index].checkValue,
            keyValue: groupToDo.doneList[index].item,
            onChecked: (v) => groupToDo.markAsUndone(
                value: v, index: index, key: groupToDo.title),
            onDismissed: (d) => groupToDo.dismissDone(
                direction: DismissDirection.startToEnd,
                index: index,
                key: groupToDo.title),
            onTap: () => showModalBottomSheet(
                backgroundColor: kBackgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                context: context,
                builder: (context) => ModalBottomSheet(
                      defaultText: groupToDo.doneList[index].item,
                      type: 'groupDone',
                      index: index,
                      keyValue: groupToDo.title,
                    )),
          );
        },
        itemCount: groupToDo.doneList.length,
      );
    });
  }
}
