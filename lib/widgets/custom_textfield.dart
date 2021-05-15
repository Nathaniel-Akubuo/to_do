import 'package:flutter/material.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/constants/text_styles.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final hintText;

  CustomTextfield({this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    final maxLines = 5;
    final mediaQuery = MediaQuery.of(context).size;
    return Theme(
      data: ThemeData(primaryColor: kBlue),
      child: Container(
        margin: EdgeInsets.all(12),
        width: mediaQuery.width * 0.8,
        height: mediaQuery.height * 0.08,
        decoration: BoxDecoration(
            color: kTileColor,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: TextField(
          controller: controller,
          autofocus: true,
          style: kTaskStyle,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.all(10)
          ),
        ),
      ),
    );
  }
}
