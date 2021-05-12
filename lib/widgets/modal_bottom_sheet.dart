import 'package:flutter/material.dart';
import 'package:to_do/util/to_do.dart';
import 'custom_textfield.dart';
import 'package:to_do/constants/colors.dart';
import 'package:provider/provider.dart';

class ModalBottomSheet extends StatefulWidget {
  final defaultText;
  final route;
  final index;

  ModalBottomSheet({this.defaultText, this.route = 'add', this.index});

  @override
  _ModalBottomSheetState createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  var controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    controller.text = widget.defaultText;
    controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
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
              child: Consumer<ToDo>(
                builder: (context, child, toDo) {
                  var toDo = Provider.of<ToDo>(context, listen: false);
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: kBlue),
                    child: Container(
                        child: Text('ADD', style: TextStyle(fontSize: 20))),
                    onPressed: () {
                      switch (widget.route) {
                        case 'undone':
                          toDo.editUndoneToDo(controller.text, widget.index);
                          break;
                        case 'done':
                          toDo.editDoneToDo(controller.text, widget.index);
                          break;
                        case 'add':
                          toDo.addToDo(controller.text);
                          break;
                      }
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
