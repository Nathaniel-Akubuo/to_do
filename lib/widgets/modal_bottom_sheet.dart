import 'package:flutter/material.dart';
import 'package:to_do/util/to_do.dart';
import 'custom_textfield.dart';
import 'package:to_do/constants/colors.dart';
import 'package:provider/provider.dart';

class ModalBottomSheet extends StatefulWidget {
  @override
  _ModalBottomSheetState createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  var controller = TextEditingController();

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
              controller: controller,
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
                  title = controller.text;
                  Provider.of<ToDo>(context, listen: false).addToDo(title);
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
