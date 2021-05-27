import 'package:cloud_firestore/cloud_firestore.dart';

class CompletedHomeworkPoolDataProvider {
  final String therapistId;
  final FirebaseFirestore firestoreInstance;

  CompletedHomeworkPoolDataProvider({
    required this.therapistId,
    required this.firestoreInstance,
  });

  Future<QuerySnapshot> getRawCompletedHomeworkPool(
      {required String clientId}) async {
    QuerySnapshot rawCompletedHomeworkPool = await firestoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("clients")
        .doc(clientId)
        .collection("completedHomework")
        .orderBy("dateTimeAnswered", descending: false)
        .get();

    return rawCompletedHomeworkPool;
  }
}
