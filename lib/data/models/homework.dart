import 'package:cloud_firestore/cloud_firestore.dart';

class Homework {
  final String id;
  String title;
  List<dynamic> fields;
  final DateTime? dateCreated;

  Homework({
    required this.id,
    this.title = "",
    this.fields = const [],
    this.dateCreated,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "fields": fields,
        "dateCreated": Timestamp.fromDate(dateCreated!),
      };
}
