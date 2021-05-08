import 'dart:collection';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../dataproviders/homeworkpoolDataProvider.dart';
import '../models/homeworkpool.dart';
import '../models/homework.dart';

class HomeworkPoolRepository {
  final FirebaseFirestore firestoreInstance;
  final String therapistId;
  late HomeworkPoolDataProvider homeworkPoolDataProvider;
  late HomeworkPool homeworkPool;

  HomeworkPoolRepository(
      {required this.firestoreInstance, required this.therapistId}) {
    homeworkPoolDataProvider = HomeworkPoolDataProvider(
      firestoreInstance: firestoreInstance,
      therapistId: therapistId,
    );

    homeworkPool = HomeworkPool();
  }

  Future<HomeworkPool> getHomeworkPool() async {
    final QuerySnapshot rawHomeworkPool =
        await homeworkPoolDataProvider.getRawHomeworkPool();

    rawHomeworkPool.docs.forEach((rawHomework) {
      homeworkPool.data[rawHomework.id] = new Homework(
        id: rawHomework.id,
        title: rawHomework["title"],
        fields: rawHomework["fields"],
        dateCreated: rawHomework["dateCreated"].toDate(),
      );
    });

    return homeworkPool;
  }
}
