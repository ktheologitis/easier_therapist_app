import 'package:easier_therapist_app/data/models/homework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../logic/homeworkpoolbloc/homeworkpoolbarrel.dart';

enum Mode {
  create,
  update,
}

Future<void> showCreateUpdateHomeworkDialog(
    {required BuildContext context,
    required Mode mode,
    Homework? existingHomework}) async {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;

  final formKey = GlobalKey<FormState>();
  final Uuid uuid = Uuid();
  final homeworkPoolBloc = BlocProvider.of<HomeworkPoolBloc>(context);
  final Homework newHomework = mode == Mode.create
      ? Homework(
          id: uuid.v1(),
        )
      : Homework(
          id: existingHomework!.id,
          dateCreated: existingHomework.dateCreated,
          fields: [...existingHomework.fields],
          title: existingHomework.title,
        );

  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        FocusNode myFocusNode = new FocusNode();

        return AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          title: Text("Create new homework"),
          content: StatefulBuilder(
            builder: (context, setState) {
              myFocusNode.requestFocus();
              return SizedBox(
                height: height - (height * 0.1 * 2),
                width: width - (width * 0.2 * 2),
                child: AddNewHomeworkForm(
                  formkey: formKey,
                  newHomework: newHomework,
                  myFocusNode: myFocusNode,
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
                  if (formKey.currentState!.validate()) {
                    formKey.currentState?.save();
                    print(newHomework.fields);
                    if (mode == Mode.create) {
                      homeworkPoolBloc
                          .add(HomeworkAdded(homework: newHomework));
                    } else {
                      homeworkPoolBloc
                          .add(HomeworkUpdated(updatedHomework: newHomework));
                    }
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        );
      });
}

class AddNewHomeworkForm extends StatefulWidget {
  const AddNewHomeworkForm({
    Key? key,
    required this.formkey,
    required this.newHomework,
    required this.myFocusNode,
  }) : super(key: key);

  final GlobalKey formkey;
  final Homework newHomework;
  final FocusNode myFocusNode;

  @override
  _AddNewHomeworkFormState createState() => _AddNewHomeworkFormState();
}

class _AddNewHomeworkFormState extends State<AddNewHomeworkForm> {
  final TextEditingController titleController = new TextEditingController();
  late List<TextEditingController> fieldControllers;
  late List<String> fields;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.newHomework.title;
    if (widget.newHomework.fields.isNotEmpty) {
      fields = [...widget.newHomework.fields];
      fieldControllers = [];
      for (var i = 0; i <= fields.length - 1; i++) {
        fieldControllers.add(new TextEditingController());
        fieldControllers[i].text = fields[i];
      }
    } else {
      fields = [""];
      fieldControllers = [new TextEditingController()];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
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
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter title",
            ),
            onSaved: (value) {
              if (value != null) {
                widget.newHomework.title = value;
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please provide a homework title";
              }
            },
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
                itemBuilder: (context, index) {
                  return Row(
                    key: UniqueKey(),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextFormField(
                          focusNode: (index == fieldControllers.length - 1 &&
                                  index != 0)
                              ? widget.myFocusNode
                              : null,
                          controller: fieldControllers[index],
                          maxLines: null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Add new field",
                          ),
                          onSaved: (value) {
                            if (value != null) {
                              fields[index] = value;
                              widget.newHomework.fields = fields;
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please provide field content, or remove the current field";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      if (index == fieldControllers.length - 1)
                        Row(
                          children: [
                            index != 0
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        fieldControllers.removeAt(index);
                                        fields.removeAt(index);
                                        widget.newHomework.fields = fields;
                                      });
                                    },
                                    icon: Icon(Icons.remove),
                                  )
                                : SizedBox(
                                    width: 40.0,
                                  ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  fieldControllers
                                      .add(new TextEditingController());
                                  fields.add("");
                                  widget.newHomework.fields = fields;
                                });
                              },
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      if (index != fieldControllers.length - 1)
                        Row(
                          children: [
                            SizedBox(
                              width: 40.0,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    fieldControllers.removeAt(index);
                                    fields.removeAt(index);
                                    widget.newHomework.fields = fields;
                                  });
                                },
                                icon: Icon(Icons.remove)),
                          ],
                        ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 16.0,
                    ),
                itemCount: fieldControllers.length),
          ),
        ],
      ),
    );
  }
}
