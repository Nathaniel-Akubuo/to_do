import 'package:flutter/material.dart';

const kBlue = Color(0xff3068DF);
const kTeal = Color(0xff1EBEC0);
const kOrange = Color(0xffF65C26);

final dark = ThemeData(
  primaryColor: Colors.black,
  accentColor: Color(0xff3068DF),
  cardColor: Color(0xff222228),
  textTheme: TextTheme(
    subtitle1: TextStyle(
        fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold),
    //date
    headline6: TextStyle(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
    //title
    subtitle2: TextStyle(
        fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold), //task
    caption: TextStyle(
        fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold),
  ),
);

final light = ThemeData(
  primaryColor: Color(0xffF5F5F8),
  accentColor: Color(0xff3068DF),
  cardColor: Colors.white,
  textTheme: TextTheme(
    subtitle1: TextStyle(
        fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold),
    //date
    headline6: TextStyle(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
    //title
    subtitle2: TextStyle(
        fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold), //
    caption: TextStyle(
        fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
  ),
);
const kDoneTaskStyle = TextStyle(
    fontSize: 16,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.lineThrough);
