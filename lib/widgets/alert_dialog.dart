import 'package:flutter/material.dart';
import 'package:to_do/constants/themes.dart';

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
        style: Theme.of(context).textTheme.headline6,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Text(
        content,
        style: Theme.of(context).textTheme.subtitle2,
      ),
      backgroundColor: Theme.of(context).cardColor,
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
