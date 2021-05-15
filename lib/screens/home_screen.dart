import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:to_do/constants/text_styles.dart';
import 'package:to_do/widgets/done_listview.dart';
import 'package:to_do/widgets/group_widget_builder.dart';
import 'package:to_do/widgets/to_do_group_bubble.dart';
import 'package:to_do/widgets/undone_listview.dart';
import '../widgets/modal_bottom_sheet.dart';
import '../constants/colors.dart';
import 'package:provider/provider.dart';
import '../util/to_do.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ToDo>(context, listen: false).initPrefs();

    final mediaQuery = MediaQuery.of(context).size;

    return Consumer<ToDo>(
      builder: (context, child, toDo) {
        var toDo = Provider.of<ToDo>(context, listen: true);
        return SafeArea(
          child: Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: AppBar(
                title: Text(
                  'Home',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backgroundColor: kBackgroundColor,
                elevation: 0),
            floatingActionButton: FloatingActionButtons(),
            body: Container(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ToDoGroupBubble(
                        width: mediaQuery.width,
                        title: 'tiit',
                        date:
                            '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}',
                      ),
                      SizedBox(height: 35),
                      Text(
                        'Projects',
                        style: kTitleStyle,
                      ),
                      SizedBox(height: 20),
                      Container(
                          height: mediaQuery.height * 0.21,
                          width: mediaQuery.width,
                          child: ToDoGroupListView()),
                      SizedBox(height: 35),
                      Text(
                        'Tasks',
                        style: kTitleStyle,
                      ),
                      SizedBox(height: 20),
                      Container(
                          width: double.infinity, child: UndoneListView()),
                      SizedBox(height: 60),
                      Container(
                          width: double.infinity,
                          height: 100,
                          child: DoneListView())
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class FloatingActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FloatingActionButton.extended(
          onPressed: () => showModalBottomSheet(
              backgroundColor: kBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              context: context,
              builder: (context) => ModalBottomSheet(
                    type: 'homeScreen',
                  )),
          label: Text('+ CREATE NEW GROUP'),
        ),
        FloatingActionButton(
            backgroundColor: kBlue,
            child: Icon(Icons.add),
            onPressed: () => showModalBottomSheet(
                backgroundColor: kBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                context: context,
                builder: (context) => ModalBottomSheet(type: 'homeAdd')))
      ],
    );
  }
}
