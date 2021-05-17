import 'package:flutter/material.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/constants/text_styles.dart';

class ToDoGroupBubble extends StatelessWidget {
  final bool calledFromHome;
  final String title;
  final date;
  final color;
  final width;
  final height;
  final Function onTap;
  final Function onLongPress;
  final child;

  ToDoGroupBubble(
      {this.title,
      this.onTap,
      this.color,
      this.width,
      this.date,
      this.calledFromHome = false,
      this.child,
      this.onLongPress,
      this.height});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return calledFromHome
        ? Container(
            width: this.width ?? mediaQuery.width * 0.4,
            decoration: BoxDecoration(
                color: kTileColor,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: child),
          )
        : GestureDetector(
            onLongPress: onLongPress,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          title,
                          style: kTitleStyle.copyWith(fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          date,
                          style: kDateTextStyle,
                        ),
                      ),
                      Container(child: child),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
