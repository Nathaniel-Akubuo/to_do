import 'package:flutter/material.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/constants/text_styles.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;

  CustomTextfield({this.controller});

  @override
  Widget build(BuildContext context) {
    final maxLines = 5;
    final mediaQuery = MediaQuery.of(context).size;
    return Theme(
        data: ThemeData(primaryColor: blue),
        child: Container(
          margin: EdgeInsets.all(12),
          width: mediaQuery.width * 0.8,
          height: mediaQuery.height * 0.08,
          child: TextField(
            controller: controller,
            style: taskStyle,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: 'Add a task here',
              hintStyle: TextStyle(color: Colors.grey),
              fillColor: tileColor,
              filled: true,
            ),
          ),
        ));
  }
}
