import 'package:flutter/material.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/constants/text_styles.dart';

class ToDoGroupBubble extends StatelessWidget {
  final bool calledFromHome;
  final String title;
  final firstItemText;
  final date;
  final color;
  final width;
  final Function onTap;

  ToDoGroupBubble(
      {this.title,
      this.onTap,
      this.color,
      this.width,
      this.firstItemText = 'Call my baby',
      this.date,
      this.calledFromHome = false});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return calledFromHome
        ? Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              width: this.width ?? mediaQuery.width * 0.4,
              height: mediaQuery.height * 0.21,
              decoration: BoxDecoration(
                  color: kTileColor,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                width: this.width ?? mediaQuery.width * 0.4,
                height: mediaQuery.height * 0.21,
                decoration: BoxDecoration(
                    color: kTileColor,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          title,
                          style: kGroupNameTextStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          firstItemText,
                          style: kTitleStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          date,
                          style: kGroupNameTextStyle.copyWith(color: color),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
