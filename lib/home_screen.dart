import 'package:flutter/material.dart';
import 'widgets/modal_bottom_sheet.dart';
import 'constants/colors.dart';
import 'widgets/grey_rounded_button.dart';
import 'widgets/undone_list_view.dart';
import 'widgets/done_list_view.dart';
import 'package:provider/provider.dart';
import 'util/to_do.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ToDo>(context, listen: false).initPrefs();
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
            title: Text(
              'Tasks',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: false,
            backgroundColor: kBackgroundColor,
            elevation: 0),
        floatingActionButton: FloatingActionButton(
            backgroundColor: kBlue,
            child: Icon(Icons.add),
            onPressed: () => showModalBottomSheet(
                backgroundColor: kBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                context: context,
                builder: (context) => ModalBottomSheet())),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  GreyRoundedButton(
                    title:
                        'You have ${Provider.of<ToDo>(context, listen: true).undoneList.length} undone task(s)',
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(child: UndoneListView()),
              SizedBox(height: 30),
              Row(
                children: [
                  GreyRoundedButton(
                    title:
                        'Hurray! You have completed ${Provider.of<ToDo>(context, listen: true).doneList.length} task(s)',
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(child: DoneListView()),
            ],
          ),
        ),
      ),
    );
  }
}
