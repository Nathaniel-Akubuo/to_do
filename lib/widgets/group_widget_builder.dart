import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/constants/text_styles.dart';
import 'package:to_do/screens/group_screen.dart';
import 'package:to_do/util/group_to_do.dart';
import 'package:to_do/widgets/alert_dialog.dart';
import 'to_do_group_bubble.dart';
import 'package:provider/provider.dart';
import 'package:to_do/util/to_do.dart';

class ToDoGroupListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ToDo>(
      builder: (context, child, toDo) {
        var toDo = Provider.of<ToDo>(context, listen: false);
        return Consumer<GroupToDo>(
          builder: (context, child, groupToDo) {
            var groupToDo = Provider.of<GroupToDo>(context, listen: true);
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: toDo.groupList.length,
                itemBuilder: (context, index) {
                  groupToDo.initPercent(toDo.groupList[index].name);
                  return Row(
                    children: [
                      ToDoGroupBubble(
                        onLongPress: () => showDialog(
                          context: context,
                          builder: (_) => AlertDialogBox(
                            content: 'Do you want to delete this group?',
                            title: 'CONFIRM',
                            onPressed: () => toDo.deleteGroup(index: index),
                          ),
                        ),
                        title: toDo.groupList[index].name,
                        date: toDo.groupList[index].dateCreated,
                        child: Row(
                          children: [
                            Expanded(
                              child: LinearPercentIndicator(
                                animateFromLastPercent: true,
                                animation: true,
                                progressColor: kBlue,
                                percent: groupToDo.percentDone(
                                    key: toDo.groupList[index].name),
                              ),
                            ),
                            Text(
                              '${(groupToDo.percentDone(key: toDo.groupList[index].name) * 100).toStringAsFixed(0)}%',
                              style: kDateTextStyle,
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GroupScreen(
                                title: toDo.groupList[index].name,
                                load: () => groupToDo
                                    .initPrefs(toDo.groupList[index].name),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                });
          },
        );
      },
    );
  }
}
