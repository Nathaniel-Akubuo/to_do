import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/constants/text_styles.dart';
import 'package:to_do/util/to_do.dart';
import 'package:to_do/widgets/done_listview.dart';
import 'package:to_do/widgets/group_widget_builder.dart';
import 'package:to_do/widgets/to_do_group_bubble.dart';
import 'package:to_do/widgets/undone_listview.dart';

class HomeScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var toDo = Provider.of<ToDo>(context, listen: true);
    final mediaQuery = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GROUPS',
          style: kTitleStyle,
        ),
        SizedBox(height: 20),
        Container(
            height: mediaQuery.height * 0.21,
            width: mediaQuery.width,
            child: toDo.groupList.length == 0
                ? Center(
                    child: Text(
                      "YOU DON'T HAVE ANY GROUP YET",
                      style: kDateTextStyle,
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
                  toDo.doneList.length == 0
                      ? '0%'
                      : '${(toDo.percentDone() * 100).toStringAsFixed(0)}%',
                  style: kDateTextStyle,
                ),
              ),
              SizedBox(width: 40),
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
                              shape: BoxShape.circle,
                             color: kBlue
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Completed: ${toDo.doneList.length}',
                        style: kTitleStyle.copyWith(
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
                        'Uncompleted: ${toDo.undoneList.length}',
                        style: kTitleStyle.copyWith(
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
                              shape: BoxShape.circle,
                              color: kBlue
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Total: ${toDo.doneList.length + toDo.undoneList.length}',
                        style: kTitleStyle.copyWith(
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
        Text(
          'TASKS',
          style: kTitleStyle,
        ),
        SizedBox(height: 20),
        Container(width: double.infinity, child: UndoneListView()),
        SizedBox(height: 20),
        Text(
          'COMPLETED',
          style: kTitleStyle.copyWith(color: Colors.grey),
        ),
        SizedBox(
          height: 20,
          child: Divider(
            color: Colors.grey,
            thickness: 0.5,
          ),
        ),
        Container(width: double.infinity, child: DoneListView()),
        SizedBox(height: 60),
      ],
    );
  }
}
