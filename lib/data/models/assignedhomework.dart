import 'dart:collection';

import 'homeworkpool.dart';

class AssignedHomework {
  final String id;
  final String referencedHomeworkId; // id of the object inside the homeworkpool
  final HomeworkPool homeworkPool;
  final String note = "";

  late String title;
  late List<dynamic> fields;

  AssignedHomework({
    required this.id,
    required this.referencedHomeworkId,
    required this.homeworkPool,
  }) {
    title = homeworkPool.data[referencedHomeworkId]!.title;
    fields = homeworkPool.data[referencedHomeworkId]!.fields;
  }
}
