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
        title: rawHomework.data()["title"],
        fields: rawHomework.data()["fields"],
        dateCreated: rawHomework.data()["dateCreated"].toDate(),
      );
    });
    return homeworkPool;
  }

  Future<void> addNewHomeworkToDatabase({required Homework homework}) async {
    await homeworkPoolDataProvider.addNewHomeworkToDatabase(homework: homework);
  }

  Future<void> deleteHomeworkFromDatabase({required String homeworkId}) async {
    await homeworkPoolDataProvider.deleteHomeworkFromDatabase(
        homeworkId: homeworkId);
  }

  Future<void> updateHomeworkInDatabase(
      {required Homework updatedHomework}) async {
    await homeworkPoolDataProvider.updateHomeworkInDatabase(
        updatedHomework: updatedHomework);
  }
}
