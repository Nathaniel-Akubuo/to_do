import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/util/group_to_do.dart';
import 'screens/home_screen.dart';
import 'util/to_do.dart';
import 'constants/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ToDo(),
      child: ChangeNotifierProvider(
        create: (context) => GroupToDo(),
        child: MaterialApp(
          theme: ThemeData(
            accentColor: kBlue
          ),
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ),
      ),
    );
  }
}
