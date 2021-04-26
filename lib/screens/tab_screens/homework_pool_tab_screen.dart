import 'package:flutter/material.dart';

import 'package:easier_therapist_app/models/homework.dart';
import '../../components/homework_pool_list_item.dart';
import '../../dialogs/create_new_homework_dialog.dart';

class HomeworkPoolTabScreen extends StatefulWidget {
  HomeworkPoolTabScreen({required this.homeworkPool});

  final List<Homework> homeworkPool;
  @override
  _HomeworkPoolTabScreenState createState() => _HomeworkPoolTabScreenState();
}

class _HomeworkPoolTabScreenState extends State<HomeworkPoolTabScreen> {
  final List<Homework> homework = [
    new Homework(title: "Functional Analysis", fields: ["YO", "YE"]),
    new Homework(title: "Second Homework", fields: ["YO", "YE"]),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(
        top: 24.0,
        bottom: 24.0,
        left: width * 0.2,
        right: width * 0.2,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Spacer(),
              TextButton.icon(
                icon: Icon(Icons.add),
                label: Text("CREATE NEW HOMEWORK"),
                onPressed: () {
                  showCreateNewHomeworkDialog(context);
                },
              ),
            ],
          ),
          SizedBox(
            height: 24.0,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: widget.homeworkPool.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.0),
              itemBuilder: (context, index) =>
                  HomeworkPoolListItem(homework: homework[index]),
            ),
          ),
        ],
      ),
    );
  }
}
