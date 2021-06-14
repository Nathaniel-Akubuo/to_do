import 'package:circular_check_box/circular_check_box.dart';
import 'package:to_do/constants/themes.dart';
import 'package:flutter/material.dart';

class ToDoBubble extends StatelessWidget {
  final String title;
  final bool isDone;
  final isChecked;
  final Function onChecked;
  final Function onDismissed;
  final String keyValue;
  final Function onTap;

  ToDoBubble(
      {this.title,
      this.isChecked = false,
      this.onChecked,
      this.onDismissed,
      this.keyValue,
      this.onTap,
      this.isDone});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Dismissible(
        key: Key(keyValue),
        background: Container(
          color: theme.primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Row(
                children: [
                  CircularCheckBox(
                      activeColor: Colors.grey,
                      inactiveColor: kBlue,
                      value: isChecked,
                      onChanged: onChecked),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(title,
                          style: isDone
                              ? kDoneTaskStyle
                              : theme.textTheme.subtitle2),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        onDismissed: onDismissed,
      ),
    );
  }
}
