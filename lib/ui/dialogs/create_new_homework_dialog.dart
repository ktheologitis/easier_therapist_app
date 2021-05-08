import 'package:flutter/material.dart';

Future<void> showCreateNewHomeworkDialog(BuildContext context) async {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;

  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        FocusNode myFocusNode = new FocusNode();
        TextEditingController _titleController = new TextEditingController();
        // List<dynamic> _homeworkFields = [""];
        List<TextEditingController> _fieldControllers = [
          new TextEditingController(),
        ];
        return AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          title: Text("Create new homework"),
          content: StatefulBuilder(
            builder: (context, setState) {
              myFocusNode.requestFocus();
              return SizedBox(
                height: height - (height * 0.1 * 2),
                width: width - (width * 0.2 * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Homework Title",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter title",
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "Fields",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => Row(
                                key: UniqueKey(),
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: TextField(
                                      focusNode: (index ==
                                                  _fieldControllers.length -
                                                      1 &&
                                              index != 0)
                                          ? myFocusNode
                                          : null,
                                      controller: _fieldControllers[index],
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Add new field",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40.0,
                                  ),
                                  if (index == _fieldControllers.length - 1)
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            // _homeworkFields.add("");
                                            _fieldControllers.add(
                                                new TextEditingController());
                                          });
                                        },
                                        icon: Icon(Icons.add)),
                                  if (index != _fieldControllers.length - 1)
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            // _homeworkFields.removeAt(index);
                                            _fieldControllers.removeAt(index);
                                          });
                                        },
                                        icon: Icon(Icons.remove)),
                                ],
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 16.0,
                              ),
                          itemCount: _fieldControllers.length),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            SizedBox(
              height: 36,
              width: 100,
              child: ElevatedButton(
                  child: Text("CLOSE"),
                  onPressed: () => Navigator.of(context).pop()),
            ),
            SizedBox(
              width: 100,
              height: 36,
              child: ElevatedButton(
                child: Text("SAVE"),
                onPressed: () {
                  // print(_homeworkFields.length);
                  print(_fieldControllers.length);
                  print(_titleController.text);
                },
              ),
            ),
          ],
        );
      });
}
