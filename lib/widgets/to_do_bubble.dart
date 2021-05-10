import 'package:circular_check_box/circular_check_box.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/constants/text_styles.dart';
import 'package:flutter/material.dart';

class ToDoBubble extends StatelessWidget {
  final String title;
  final isChecked;
  final Function onChecked;
  final Function onDismissed;
  final String keyValue;

  ToDoBubble(
      {this.title,
      this.isChecked = false,
      this.onChecked,
      this.onDismissed,
      this.keyValue});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Dismissible(
      key: Key(keyValue),
      background: Container(
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          width: double.infinity,
          height: mediaQuery.height * 0.07,
          decoration: BoxDecoration(
              color: tileColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              Theme(
                child: CircularCheckBox(value: isChecked, onChanged: onChecked),
                data: ThemeData(
                  primarySwatch: blue,
                  unselectedWidgetColor: Colors.grey, // Your color
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  title,
                  style: taskStyle,
                ),
              ))
            ],
          ),
        ),
      ),
      onDismissed: onDismissed,
    );
  }
}
