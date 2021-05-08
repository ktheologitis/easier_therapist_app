import 'dart:collection';

import 'assignedhomeworkpool.dart';

class CompletedHomework {
  final String id;
  final String referencedHomeworkId;
  final AssignedHomeworkPool assignedHomeworkPool;

  Map<dynamic, dynamic>? get fields {
    return assignedHomeworkPool.data[referencedHomeworkId]?.fields;
  }

  final Map<dynamic, dynamic> answers = {} as LinkedHashMap<String, String>;

  CompletedHomework({
    required this.id,
    required this.referencedHomeworkId,
    required this.assignedHomeworkPool,
  });
}
