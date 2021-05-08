import 'dart:collection';

class Homework {
  final String id;
  final String title;
  final Map<dynamic, dynamic> fields;
  final DateTime dateCreated;

  Homework(
      {required this.id,
      required this.title,
      required this.fields,
      required this.dateCreated});
}
