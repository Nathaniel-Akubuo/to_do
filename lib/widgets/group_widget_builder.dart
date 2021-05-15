import 'package:flutter/material.dart';
import 'package:to_do/screens/group_screen.dart';
import 'package:to_do/util/group_to_do.dart';
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
            var groupToDo = Provider.of<GroupToDo>(context, listen: false);
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: toDo.groupList.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      ToDoGroupBubble(
                        title: toDo.groupList[index].name,
                        date: toDo.groupList[index].dateCreated,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GroupScreen(
                                  title: toDo.groupList[index].name,
                                  load: () => groupToDo
                                      .initPrefs(toDo.groupList[index].name),
                                ),
                              ));
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
