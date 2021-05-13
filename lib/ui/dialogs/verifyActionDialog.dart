import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/homeworkpoolbloc/homeworkpoolbarrel.dart';

Future<void> showVerifyActionDialog({
  required BuildContext context,
  required String title,
  required String homeworkId,
}) async {
  final width = MediaQuery.of(context).size.width;
  final HomeworkPoolBloc homeworkPoolBloc =
      BlocProvider.of<HomeworkPoolBloc>(context);

  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text(title),
          actions: [
            SizedBox(
              height: 36,
              width: 100,
              child: ElevatedButton(
                  child: Text("NO"),
                  onPressed: () => Navigator.of(context).pop()),
            ),
            SizedBox(
              width: 100,
              height: 36,
              child: ElevatedButton(
                child: Text("YES"),
                onPressed: () {
                  homeworkPoolBloc.add(HomeworkDeleted(homeworkId: homeworkId));
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      });
}
