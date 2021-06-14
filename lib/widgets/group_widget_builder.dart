import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:to_do/constants/themes.dart';
import 'package:to_do/models/task_screen_model.dart';
import 'package:to_do/screens/group_screen.dart';
import 'package:to_do/util/hive_database.dart';
import 'package:to_do/widgets/alert_dialog.dart';
import 'to_do_group_bubble.dart';
import 'package:provider/provider.dart';
import 'package:to_do/util/to_do.dart';

class ToDoGroupListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var toDo = Provider.of<ToDo>(context, listen: false);
    return Consumer<HiveDatabase>(
      builder: (context, child, groupToDo) {
        var groupToDo = Provider.of<HiveDatabase>(context, listen: true);
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: Hive.box('group').length,
            itemBuilder: (context, index) {
              var currentGroupBox =
                  Hive.box('group').getAt(index) as TaskScreenModel;
              groupToDo.openBox(currentGroupBox.name);
              return Row(
                children: [
                  ToDoGroupBubble(
                    onLongPress: () => showDialog(
                      context: context,
                      builder: (_) => AlertDialogBox(
                          content: 'Do you want to delete this group?',
                          title: 'CONFIRM',
                          onPressed: () => toDo.deleteGroup(index: index)),
                    ),
                    title: currentGroupBox.name,
                    date: currentGroupBox.dateCreated,
                    child: Row(
                      children: [
                        Expanded(
                          child: LinearPercentIndicator(
                            animateFromLastPercent: true,
                            animation: true,
                            progressColor: kBlue,
                            percent: groupToDo.percentDone(
                                key: currentGroupBox.name),
                          ),
                        ),
                        Text(
                          '${(groupToDo.percentDone(key: currentGroupBox.name) * 100).toStringAsFixed(0)}%',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return GroupScreen(title: currentGroupBox.name);
                          },
                        ),
                      );
                    },
                  ),
                ],
              );
            });
      },
    );
  }
}
