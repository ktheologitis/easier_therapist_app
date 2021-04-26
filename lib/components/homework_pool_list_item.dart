import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:easier_therapist_app/models/homework.dart';

class HomeworkPoolListItem extends StatelessWidget {
  HomeworkPoolListItem({required this.homework});

  final Homework homework;

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
                  print("Edit homework");
                },
                icon: Icon(Icons.edit)),
            SizedBox(
              width: 16.0,
            ),
            IconButton(
                onPressed: () {
                  print("Delete from homework pool");
                },
                icon: Icon(Icons.delete)),
          ],
        ));
  }
}
