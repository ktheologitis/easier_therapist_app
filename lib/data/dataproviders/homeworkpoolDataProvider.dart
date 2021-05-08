import 'package:cloud_firestore/cloud_firestore.dart';

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
}
