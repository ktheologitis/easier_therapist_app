import 'package:easier_therapist_app/ui/dialogs/editNoteDialog.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/homework.dart';
import '../../logic/assignedhomeworkpoolbloc/assignedhomeworkpoolbarrel.dart';
import '../../data/models/homeworkpool.dart';
import '../../data/models/assignedhomework.dart';
import '../../data/models/assignedhomeworkpool.dart';

Future<void> showAssignHomeworkDialog({
  required BuildContext context,
  required HomeworkPool homeworkPool,
}) async {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  Map<String, AssignedHomework> toBeAssigned = {};

  void handleAddAssignedHomework({required AssignedHomework assignedHomework}) {
    toBeAssigned[assignedHomework.id] = assignedHomework;
  }

  void handleRemoveAssignedHomework({required String homeworkId}) {
    toBeAssigned.removeWhere(
        (key, assigndHomework) => assigndHomework.id == homeworkId);
  }

  void handleNoteChange(String assignedHomeworkId, String note) {
    toBeAssigned[assignedHomeworkId]!.note = note;
  }

  HomeworkPool filterHomeworkPool(
      HomeworkPool homeworkPool, AssignedHomeworkPool assignedHomeworkPool) {
    HomeworkPool filteredHomeworkPool = new HomeworkPool();
    filteredHomeworkPool.data = {...homeworkPool.data};

    if (assignedHomeworkPool.data.isEmpty) {
      return homeworkPool;
    } else {
      List<String> alreadyAssignedHomeworkPoolIds = assignedHomeworkPool
          .data.values
          .map((assignedHomework) => assignedHomework.referencedHomeworkId)
          .toList();

      filteredHomeworkPool.data.removeWhere((homeworkId, _) =>
          alreadyAssignedHomeworkPoolIds.contains(homeworkId));

      return filteredHomeworkPool;
    }
  }

  return await showDialog(
      context: context,
      builder: (_) {
        final AssignedHomeworkPoolBloc assignedHomeworkPoolBloc =
            BlocProvider.of<AssignedHomeworkPoolBloc>(context);
        final AssignedHomeworkPool assignedHomeworkPool =
            assignedHomeworkPoolBloc.state.assignedHomeworkPool;
        final clientId = assignedHomeworkPoolBloc.state.clientId;

        final HomeworkPool filteredHomeworkPool = homeworkPool.data.length > 0
            ? filterHomeworkPool(homeworkPool, assignedHomeworkPool)
            : homeworkPool;

        return AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          title: Text("Assign Homework"),
          content: SizedBox(
            width: width - width * 0.7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (filteredHomeworkPool.data.length > 0)
                  Text("Choose homework(s) to assign from your homework pool."),
                if (filteredHomeworkPool.data.length == 0)
                  Text(
                      "You have assigned all of your existing homeworks to this client."),
                if (homeworkPool.data.length == 0)
                  Text(
                      "Your homework pool is currently empty. Create some homework and come back to assign it!"),
                SizedBox(
                  height: 24,
                ),
                if (homeworkPool.data.length > 0)
                  SizedBox(
                    height: homeworkPool.data.length == 0 ||
                            filteredHomeworkPool.data.length == 0
                        ? 10
                        : height * 0.4,
                    child: ListView.separated(
                      itemCount: filteredHomeworkPool.data.length,
                      separatorBuilder: (context, _) => SizedBox(
                        height: 8,
                      ),
                      itemBuilder: (context, index) {
                        return HomeworkPoolItemChoice(
                          homework: filteredHomeworkPool.data.values
                              .toList()
                              .reversed
                              .toList()[index],
                          addAssignedHomework: handleAddAssignedHomework,
                          removeAssignedHomework: handleRemoveAssignedHomework,
                          handleNoteChange: handleNoteChange,
                        );
                      },
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
                  child: homeworkPool.data.length == 0 ||
                          filteredHomeworkPool.data.length == 0
                      ? Text("CLOSE")
                      : Text("CANCEL"),
                  onPressed: () => Navigator.of(context).pop()),
            ),
            if (filteredHomeworkPool.data.length > 0)
              SizedBox(
                width: 100,
                height: 36,
                child: ElevatedButton(
                  child: Text("ASSIGN"),
                  onPressed: () {
                    assignedHomeworkPoolBloc.add(AssignedHomeworkAdded(
                      clientId: clientId,
                      assignedHomeworks: toBeAssigned.values.toList(),
                    ));
                    Navigator.of(context).pop();
                  },
                ),
              ),
            if (homeworkPool.data.length == 0)
              SizedBox(
                width: 100,
                height: 36,
                child: ElevatedButton(
                  child: Text("CREATE"),
                  onPressed: () {
                    Navigator.of(context).popUntil(ModalRoute.withName("/"));
                  },
                ),
              ),
          ],
        );
      });
}

class HomeworkPoolItemChoice extends StatefulWidget {
  HomeworkPoolItemChoice({
    required this.homework,
    required this.addAssignedHomework,
    required this.removeAssignedHomework,
    required this.handleNoteChange,
  });
  final Homework homework;
  final Function addAssignedHomework;
  final Function removeAssignedHomework;
  final Function handleNoteChange;

  @override
  _HomeworkPoolItemChoiceState createState() => _HomeworkPoolItemChoiceState();
}

class _HomeworkPoolItemChoiceState extends State<HomeworkPoolItemChoice> {
  bool _checkboxValue = false;
  String _currentNote = "";
  final String assignedHomeworkId = Uuid().v1();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(widget.homework.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              icon: Icon(Icons.note),
              onPressed: () async {
                String note = await showNoteDialog(
                  context: context,
                  homeworkTitle: widget.homework.title,
                  currentNote: _currentNote,
                );
                _currentNote = note;

                if (_checkboxValue == true) {
                  widget.handleNoteChange(assignedHomeworkId, _currentNote);
                }
              }),
          SizedBox(
            width: 16,
          ),
          Checkbox(
              value: _checkboxValue,
              onChanged: (val) {
                setState(() {
                  _checkboxValue = !_checkboxValue;
                  if (_checkboxValue == true) {
                    widget.addAssignedHomework(
                        assignedHomework: new AssignedHomework(
                      id: assignedHomeworkId,
                      referencedHomeworkId: widget.homework.id,
                      homework: widget.homework,
                      note: _currentNote,
                    ));
                  } else {
                    widget.removeAssignedHomework(
                        homeworkId: widget.homework.id);
                  }
                });
              })
        ],
      ),
    );
  }
}
