import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/util/group_to_do.dart';
import 'package:to_do/widgets/grey_rounded_button.dart';
import 'package:to_do/widgets/group_done_listview.dart';
import 'package:to_do/widgets/group_undone_listview.dart';
import 'package:to_do/widgets/modal_bottom_sheet.dart';


class GroupScreen extends StatefulWidget {
  final title;
  final Function load;

  GroupScreen({this.title, this.load});

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  var controller = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    widget.load();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<GroupToDo>(context, listen: false).title = widget.title;
    return SafeArea(
      child: Consumer<GroupToDo>(
        builder: (context, child, groupToDo) {
          var groupToDo = Provider.of<GroupToDo>(context, listen: false);
          return Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: AppBar(
              backgroundColor: kBackgroundColor,
              title: Text(widget.title),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: kBlue,
                child: Icon(Icons.add),
                onPressed: () => showModalBottomSheet(
                    backgroundColor: kBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    context: context,
                    builder: (context) => ModalBottomSheet(
                          type: 'groupScreenAdd',
                          keyValue: widget.title,
                        ))),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      GreyRoundedButton(
                        title: (groupToDo.undoneList.length == 1)
                            ? 'You have ${groupToDo.undoneList.length} undone task'
                            : 'You have ${groupToDo.undoneList.length} undone tasks',
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    flex: 3,
                    child: GroupUndoneListView(),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      GreyRoundedButton(
                        title: (groupToDo.doneList.length == 0)
                            ? 'You have completed ${groupToDo.doneList.length} tasks'
                            : (groupToDo.doneList.length == 1)
                                ? 'Hurray! You have completed ${groupToDo.doneList.length} task'
                                : 'Hurray! You have completed ${groupToDo.doneList.length} tasks',
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    flex: 2,
                    child: GroupDoneListView(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
