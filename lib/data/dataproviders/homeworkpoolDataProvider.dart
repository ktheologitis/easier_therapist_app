import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/homework.dart';

class HomeworkPoolDataProvider {
  final FirebaseFirestore firestoreInstance;
  final String therapistId;

  HomeworkPoolDataProvider(
      {required this.firestoreInstance, required this.therapistId});

  Future<QuerySnapshot> getRawHomeworkPool() async {
    Future<QuerySnapshot> rawHomeworkPool = firestoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("homeworkPool")
        .get()
        .catchError((err) {
      print("getRawHomeworkPool error: $err");
    });
    return rawHomeworkPool;
  }

  Future<void> addNewHomeworkToDatabase({required Homework homework}) async {
    firestoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("homeworkPool")
        .doc(homework.id)
        .set(homework.toFirestoreJson());
  }

  Future<void> deleteHomeworkFromDatabase({required String homeworkId}) async {
    await firestoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("homeworkPool")
        .doc(homeworkId)
        .delete();
  }

  Future<void> updateHomeworkInDatabase(
      {required Homework updatedHomework}) async {
    await firestoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("homeworkPool")
        .doc(updatedHomework.id)
        .update(updatedHomework.toFirestoreJson());
  }
}
