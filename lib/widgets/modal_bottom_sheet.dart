import 'package:flutter/material.dart';
import 'package:to_do/util/to_do.dart';
import 'custom_textfield.dart';
import 'package:to_do/constants/colors.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ModalBottomSheet extends StatelessWidget {
//  var controller = TextEditingController();
//  void _setText() {
//    title = controller.text;
//  }

  @override
  Widget build(BuildContext context) {
    var title;
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: mediaQuery.height * 0.4,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextfield(
              onChanged: (value) => title = value,
            ),
            SizedBox(height: 20),
            Container(
              width: mediaQuery.width * 0.8,
              height: mediaQuery.height * 0.08,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: blue),
                child: Container(
                    child: Text('ADD', style: TextStyle(fontSize: 20))),
                onPressed: () {
                  Provider.of<ToDo>(context, listen: false).addToDo(title);
                  print('nathaniel');
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
