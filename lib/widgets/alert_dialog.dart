import 'package:flutter/material.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/constants/text_styles.dart';

class AlertDialogBox extends StatelessWidget {
  final content;
  final onPressed;
  final title;

  AlertDialogBox({this.content, this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: kTitleStyle,
      ),
      content: Text(
        content,
        style: kTaskStyle,
      ),
      backgroundColor: kTileColor,
      actions: [
        TextButton(
          onPressed: () {
            onPressed();
            Navigator.of(context).pop();
          },
          child: Text(
            'OK',
            style: TextStyle(color: kBlue),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'CANCEL',
            style: TextStyle(color: kBlue),
          ),
        )
      ],
    );
  }
}
