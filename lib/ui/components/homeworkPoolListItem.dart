import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:ui';
import '../../data/models/homework.dart';
import '../../logic/homeworkpoolbloc/homeworkpoolbarrel.dart';
import '../dialogs/verifyActionDialog.dart';
import '../dialogs/createNewHomeworkDialog.dart';

class HomeworkPoolListItem extends StatelessWidget {
  HomeworkPoolListItem({required this.homework});

  final Homework homework;

  @override
  Widget build(BuildContext context) {
    HomeworkPoolBloc homeworkPoolBloc =
        BlocProvider.of<HomeworkPoolBloc>(context);

    void handleDeleteHomework() {
      homeworkPoolBloc.add(HomeworkDeleted(homeworkId: homework.id));
      Navigator.of(context).pop();
    }

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
                  showCreateUpdateHomeworkDialog(
                      context: context,
                      mode: Mode.update,
                      existingHomework: homework);
                },
                icon: Icon(Icons.edit)),
            SizedBox(
              width: 16.0,
            ),
            IconButton(
                onPressed: () {
                  showVerifyActionDialog(
                      context: context,
                      title: "Are you sure you want to delete this homework?",
                      action: handleDeleteHomework);
                },
                icon: Icon(Icons.delete)),
          ],
        ));
  }
}
