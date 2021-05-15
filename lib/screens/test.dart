import 'package:flutter/material.dart';
import 'package:to_do/widgets/modal_bottom_sheet.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/widgets/grey_rounded_button.dart';
import 'package:to_do/widgets/undone_listview.dart';
import 'package:to_do/widgets/done_listview.dart';
import 'package:provider/provider.dart';
import 'package:to_do/util/to_do.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ToDo>(context, listen: false).initPrefs();
    return Consumer<ToDo>(
      builder: (context, child, toDo) {
        var toDo = Provider.of<ToDo>(context, listen: true);
        return SafeArea(
          child: Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: AppBar(
                title: Text(
                  'Tasks',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                centerTitle: false,
                backgroundColor: kBackgroundColor,
                elevation: 0),
            floatingActionButton: FloatingActionButton(
                backgroundColor: kBlue,
                child: Icon(Icons.add),
                onPressed: () => showModalBottomSheet(
                    backgroundColor: kTileColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    context: context,
                    builder: (context) => ModalBottomSheet(type: 'homeScreen',))),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GreyRoundedButton(
                        title: (toDo.undoneList.length == 1)
                            ? 'You have ${toDo.undoneList.length} undone task'
                            : 'You have ${toDo.undoneList.length} undone tasks',
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Expanded(child: UndoneListView()),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      GreyRoundedButton(
                        title: (toDo.doneList.length == 1)
                            ? 'Hurray! You have completed ${toDo.doneList.length} task'
                            : 'Hurray! You have completed ${toDo.doneList.length} tasks',
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Expanded(child: DoneListView()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
