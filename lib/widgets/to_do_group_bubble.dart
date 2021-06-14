import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
    return calledFromHome
        ? Card(
            elevation: 2,
            color: theme.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
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
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  width: this.width ?? mediaQuery.width * 0.4,
                  height: mediaQuery.height * 0.21,
                  decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(15)),
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
                            style: theme.textTheme.headline6
                                .copyWith(fontSize: 17),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            date,
                            style: theme.textTheme.subtitle1,
                          ),
                        ),
                        Container(child: child),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
