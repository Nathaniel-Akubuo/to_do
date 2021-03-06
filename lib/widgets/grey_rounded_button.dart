import 'package:flutter/material.dart';
import 'package:to_do/constants/themes.dart';

class GreyRoundedButton extends StatelessWidget {
  final String title;

  GreyRoundedButton({this.title});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: mediaQuery.height * 0.0455,
      decoration: BoxDecoration(
          color: kBlue, borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.width * 0.025,
            vertical: mediaQuery.height * 0.012),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}
