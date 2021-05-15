import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:to_do/constants/colors.dart';

class DottedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return DottedBorder(
      dashPattern: [6, 3],
      color: Colors.white,
      borderType: BorderType.RRect,
      radius: Radius.circular(15),
      child: Container(
        decoration: BoxDecoration(
            color: kTileColor,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        width: mediaQuery.width * 0.4,
        height: mediaQuery.height * 0.21,
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
