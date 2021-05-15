import 'package:flutter/material.dart';
import 'package:to_do/util/to_do.dart';
import 'custom_textfield.dart';
import 'package:to_do/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:to_do/util/group_to_do.dart';

class ModalBottomSheet extends StatefulWidget {
  final defaultText;
  final keyValue;
  final type;
  final index;

  ModalBottomSheet(
      {this.defaultText, this.type = 'default', this.index, this.keyValue});

  @override
  _ModalBottomSheetState createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  var controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    controller.text = widget.defaultText;
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: mediaQuery.height * 0.4,
      child: Center(
        child: widget.type == 'homeScreen'
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextfield(
                    controller: controller,
                    hintText: 'Add name of new group',
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: mediaQuery.width * 0.8,
                    height: mediaQuery.height * 0.08,
                    child: Consumer<ToDo>(
                      builder: (context, child, toDo) {
                        var toDo = Provider.of<ToDo>(context, listen: false);
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: kBlue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: Container(
                            child: Text('+ CREATE NEW GROUP',
                                style: TextStyle(fontSize: 20)),
                          ),
                          onPressed: () {
                            toDo.addNewGroup(controller.text.toUpperCase());
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextfield(
                    controller: controller,
                    hintText: 'Add a task here',
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: mediaQuery.width * 0.8,
                    height: mediaQuery.height * 0.08,
                    child: Consumer<ToDo>(
                      builder: (context, child, toDo) {
                        var toDo = Provider.of<ToDo>(context, listen: false);
                        return Consumer<GroupToDo>(
                          builder: (context, child, groupToDo) {
                            var groupToDo =
                                Provider.of<GroupToDo>(context, listen: false);
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: kBlue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Container(
                                  child: Text('ADD',
                                      style: TextStyle(fontSize: 20))),
                              onPressed: () {
                                switch (widget.type) {
                                  case 'homeUndone':
                                    toDo.editUndoneToDo(
                                        controller.text, widget.index);
                                    break;
                                  case 'homeDone':
                                    toDo.editDoneToDo(
                                        controller.text, widget.index);
                                    break;
                                  case 'homeAdd':
                                    toDo.addToDo(controller.text);
                                    break;
                                  case 'groupScreenAdd':
                                    groupToDo.add(
                                        text: controller.text,
                                        key: widget.keyValue);
                                    break;
                                  case 'groupUndone':
                                    groupToDo.editDoneToDo(
                                        item: controller.text,
                                        index: widget.index,
                                        key: widget.keyValue);
                                    break;
                                  case 'groupDone':
                                    groupToDo.editDoneToDo(
                                        item: controller.text,
                                        index: widget.index,
                                        key: widget.keyValue);
                                    break;
                                }
                                Navigator.pop(context);
                              },
                            );
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
