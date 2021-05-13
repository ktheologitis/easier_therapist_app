import 'dart:collection';

import 'homeworkpool.dart';

class AssignedHomework {
  final String id;
  final String referencedHomeworkId; // id of the object inside the homeworkpool
  final HomeworkPool homeworkPool;
  final String note = "";

  String? get title {
    return homeworkPool.data[referencedHomeworkId]?.title;
  }

  List<dynamic>? get fields {
    return homeworkPool.data[referencedHomeworkId]?.fields;
  }

  AssignedHomework({
    required this.id,
    required this.referencedHomeworkId,
    required this.homeworkPool,
  });
}
