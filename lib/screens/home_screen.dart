import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:to_do/widgets/home_screen_layout.dart';
import '../widgets/modal_bottom_sheet.dart';
import '../constants/colors.dart';
import 'package:provider/provider.dart';
import '../util/to_do.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  String day;
  int date;
  String month;

  void setDayAndDate() {
    date = DateTime.now().day;
    var weekday = DateTime.now().weekday;

    switch (weekday) {
      case 1:
        day = 'Monday';
        break;
      case 2:
        day = 'Tuesday';
        break;
      case 3:
        day = 'Wednesday';
        break;
      case 4:
        day = 'Thursday';
        break;
      case 5:
        day = 'Friday';
        break;
      case 6:
        day = 'Saturday';
        break;
      case 7:
        day = 'Sunday';
    }
  }

  void setMonth() {
    var m = DateTime.now().month;
    switch (m) {
      case 1:
        month = 'January';
        break;
      case 2:
        month = 'February';
        break;
      case 3:
        month = 'March';
        break;
      case 4:
        month = 'April';
        break;
      case 5:
        month = 'May';
        break;
      case 6:
        month = 'June';
        break;
      case 7:
        month = 'July';
        break;
      case 8:
        month = 'August';
        break;
      case 9:
        month = 'September';
        break;
      case 10:
        month = 'October';
        break;
      case 11:
        month = 'November';
        break;
      case 12:
        month = 'December';
    }
  }

  @override
  Widget build(BuildContext context) {
    setDayAndDate();
    setMonth();
    Provider.of<ToDo>(context, listen: false).initPrefs();
    return Consumer<ToDo>(
      builder: (context, child, toDo) {
        var toDo = Provider.of<ToDo>(context, listen: true);
        return SafeArea(
          child: Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: AppBar(
                title: Text(
                  '$day, $date $month',
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
                  child: HomeScreenLayout(),
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
