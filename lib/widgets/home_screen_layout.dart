import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:to_do/constants/themes.dart';
import 'package:to_do/util/to_do.dart';
import 'package:to_do/widgets/done_listview.dart';
import 'package:to_do/widgets/group_widget_builder.dart';
import 'package:to_do/widgets/to_do_group_bubble.dart';
import 'package:to_do/widgets/undone_listview.dart';

class HomeScreenLayout extends StatefulWidget {
  @override
  _HomeScreenLayoutState createState() => _HomeScreenLayoutState();
}

class _HomeScreenLayoutState extends State<HomeScreenLayout> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    var toDo = Provider.of<ToDo>(context, listen: true);
    var undoneBox = Hive.box('undone');
    var doneBox = Hive.box('done');
    final mediaQuery = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('GROUPS', style: theme.textTheme.headline6),
        SizedBox(height: 20),
        Container(
            height: mediaQuery.height * 0.21,
            width: mediaQuery.width,
            child: Hive.box('group').length == 0
                ? Center(
                    child: Text(
                      "YOU DON'T HAVE ANY GROUP YET",
                      style: theme.textTheme.subtitle1,
                    ),
                  )
                : ToDoGroupListView()),
        SizedBox(height: 35),
        ToDoGroupBubble(
          width: double.infinity,
          calledFromHome: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                circularStrokeCap: CircularStrokeCap.round,
                animation: true,
                animateFromLastPercent: true,
                radius: mediaQuery.width * 0.4,
                progressColor: kBlue,
                percent: toDo.percentDone(),
                center: Text(
                  doneBox.length == 0
                      ? '0%'
                      : '${(toDo.percentDone() * 100).toStringAsFixed(0)}%',
                  style: theme.textTheme.caption,
                ),
              ),
              Expanded(child: SizedBox(width: 40)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: kBlue),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Completed: ${doneBox.length}',
                        style: theme.textTheme.headline6.copyWith(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kBlue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Uncompleted: ${undoneBox.length}',
                        style: theme.textTheme.headline6.copyWith(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: kBlue),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Total: ${undoneBox.length + doneBox.length}',
                        style: theme.textTheme.headline6.copyWith(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 35),
        Text('TASKS', style: theme.textTheme.headline6),
        SizedBox(height: 20),
        Container(width: double.infinity, child: UndoneListView()),
        SizedBox(height: 20),
        ExpansionTile(
          onExpansionChanged: (e) => setState(() {
            isExpanded = !isExpanded;
          }),
          title: Text(
            'COMPLETED',
            style: theme.textTheme.headline6,
            textAlign: TextAlign.start,
          ),
          tilePadding: EdgeInsets.all(0),
          trailing: isExpanded
              ? Icon(Icons.keyboard_arrow_up, color: kBlue)
              : Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
          children: [
            Container(width: double.infinity, child: DoneListView()),
          ],
        ),
        SizedBox(height: 60),
      ],
    );
  }
}
