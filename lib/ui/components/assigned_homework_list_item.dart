import 'package:easier_therapist_app/data/models/assignedhomework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dialogs/editNoteDialog.dart';
import '../../logic/assignedhomeworkpoolbloc/assignedhomeworkpoolbarrel.dart';

class AssignedHomeworkListItem extends StatelessWidget {
  AssignedHomeworkListItem({required this.assignedHomework});

  final AssignedHomework assignedHomework;

  @override
  Widget build(BuildContext context) {
    final AssignedHomeworkPoolBloc assignedHomeworkPoolBloc =
        BlocProvider.of<AssignedHomeworkPoolBloc>(context);

    return ListTile(
      tileColor: Colors.white,
      title: Text(
        assignedHomework.title,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.subtitle1?.fontSize,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () async {
                showNoteDialog(
                  context: context,
                  homeworkTitle: assignedHomework.title,
                  assignedHomeworkId: assignedHomework.id,
                  assignedHomeworkPoolBloc: assignedHomeworkPoolBloc,
                  currentNote: assignedHomework.note,
                  type: NoteDialogType.updateNote,
                );
              },
              icon: Icon(Icons.note)),
          SizedBox(width: 16.0),
          IconButton(
              onPressed: () {
                assignedHomeworkPoolBloc.add(AssignedHomeworkRemoved(
                  clientId: assignedHomeworkPoolBloc.state.clientId,
                  assignedHomeworkId: assignedHomework.id,
                ));
              },
              icon: Icon(Icons.remove)),
        ],
      ),
    );
  }
}
