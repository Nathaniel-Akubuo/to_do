import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task_screen_model.dart';
import 'package:to_do/models/to_do_model.dart';
import 'package:to_do/util/hive_database.dart';
import 'screens/home_screen.dart';
import 'util/to_do.dart';
import 'constants/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoModelAdapter());
  Hive.registerAdapter(TaskScreenModelAdapter());
  await Hive.openBox('group');
  await Hive.openBox('done');
  await Hive.openBox('undone');
  await Hive.openBox('percents');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ToDo()),
        ChangeNotifierProvider(create: (context) => HiveDatabase())
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        darkTheme: dark,
        theme: light,
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
