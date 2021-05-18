import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/assignedhomeworkpoolbloc/assignedhomeworkpoolbarrel.dart';

enum NoteDialogType {
  addNote,
  updateNote,
}

Future<String> showNoteDialog(
    {required BuildContext context,
    required String homeworkTitle,
    String? assignedHomeworkId,
    required String currentNote,
    required AssignedHomeworkPoolBloc assignedHomeworkPoolBloc,
    NoteDialogType type = NoteDialogType.addNote}) async {
  return await showDialog(
      context: context,
      builder: (_) {
        final height = MediaQuery.of(context).size.height;
        final width = MediaQuery.of(context).size.width;

        final TextEditingController noteController =
            TextEditingController.fromValue(
                TextEditingValue(text: currentNote));

        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          title: type == NoteDialogType.addNote
              ? Text("$homeworkTitle - Add note for patient")
              : Text("$homeworkTitle - Update note for patient"),
          content: SizedBox(
            height: height - height * 0.6,
            width: width - width * 0.7,
            child: Column(
              children: [
                Text(
                    "For example, the frequency you want them to do this homework, or anything else you might want them to remember"),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  maxLines: 10,
                  controller: noteController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            SizedBox(
              height: 36,
              width: 100,
              child: ElevatedButton(
                  child: Text("CANCEL"),
                  onPressed: () => Navigator.of(context).pop("")),
            ),
            SizedBox(
              width: 130,
              height: 36,
              child: ElevatedButton(
                child: type == NoteDialogType.addNote
                    ? Text("SAVE NOTE")
                    : Text("UPDATE NOTE"),
                onPressed: () {
                  if (type == NoteDialogType.addNote) {
                    Navigator.of(context).pop(noteController.text);
                  } else {
                    assignedHomeworkPoolBloc.add(AssignedHomeworkNoteUpdated(
                      clientId: assignedHomeworkPoolBloc.state.clientId,
                      updatedNote: noteController.text,
                      assignedHomeworkId: assignedHomeworkId!,
                    ));
                    Navigator.of(context).pop("");
                  }
                },
              ),
            ),
          ],
        );
      });
}
