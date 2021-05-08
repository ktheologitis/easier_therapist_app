import 'package:flutter/material.dart';

import '../../../data/models/homework.dart';
import '../../components/assigned_homework_list_item.dart';

class AssignedHomeworkTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            children: [
              Spacer(),
              TextButton.icon(
                icon: Icon(Icons.add),
                label: Text("ASSIGN NEW HOMEWORK"),
                onPressed: () {
                  print("Assign new homework");
                },
              ),
            ],
          ),
          SizedBox(
            height: 24.0,
          ),
          Expanded(
            child: Text("Assigned Homework"),
            // child: ListView.separated(
            //   itemCount: homework.length,
            //   separatorBuilder: (context, index) => SizedBox(height: 16.0),
            //   itemBuilder: (context, index) =>
            //       AssignedHomeworkListItem(homework: homework[index]),
            // ),
          ),
        ],
      ),
    );
  }
}
