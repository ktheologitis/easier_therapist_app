import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/assignedhomework.dart';

class AssignedHomeworkPoolDataProvider {
  final FirebaseFirestore firestoreInstance;
  final String therapistId;

  AssignedHomeworkPoolDataProvider(
      {required this.firestoreInstance, required this.therapistId});

  Future<QuerySnapshot> getClientRawAssignedHomeworkPool(
      {required String clientId}) async {
    QuerySnapshot clientRawAssignedHomeworkPool = await firestoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("clients")
        .doc(clientId)
        .collection("assignedHomework")
        .get();

    return clientRawAssignedHomeworkPool;
  }

  Future<void> addAssignedHomework(
      {required String clientId,
      required List<AssignedHomework> assignedHomeworks}) async {
    WriteBatch batch = firestoreInstance.batch();

    assignedHomeworks.forEach((assignedHomework) async {
      batch.set(
          firestoreInstance
              .collection("therapists")
              .doc(therapistId)
              .collection("clients")
              .doc(clientId)
              .collection("assignedHomework")
              .doc(assignedHomework.id),
          {
            "id": assignedHomework.id,
            "referencedHomeworkId": assignedHomework.referencedHomeworkId,
            "note": assignedHomework.note,
          });
    });
    batch.commit();
  }

  Future<void> updateAssignedHomeworkNote({
    required String clientId,
    required String assignedHomeworkId,
    required String updatedNote,
  }) async {
    await firestoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("clients")
        .doc(clientId)
        .collection("assignedHomework")
        .doc(assignedHomeworkId)
        .update({"note": updatedNote});
  }

  Future<void> removeAssignedHomework({
    required String clientId,
    required String assignedHomeworkId,
  }) async {
    await firestoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("clients")
        .doc(clientId)
        .collection("assignedHomework")
        .doc(assignedHomeworkId)
        .delete();
  }
}
