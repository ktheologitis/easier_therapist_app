import 'package:easier_therapist_app/data/models/assignedhomework.dart';
import 'package:flutter/material.dart';

import '../../data/models/homework.dart';

class AssignedHomeworkListItem extends StatelessWidget {
  AssignedHomeworkListItem({required this.homework});

  final AssignedHomework homework;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      title: Text(
        homework.title,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.subtitle1?.fontSize,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
                print("show note");
              },
              icon: Icon(Icons.note)),
          SizedBox(width: 16.0),
          IconButton(
              onPressed: () {
                print("delete client homework");
              },
              icon: Icon(Icons.delete)),
        ],
      ),
    );
  }
}
