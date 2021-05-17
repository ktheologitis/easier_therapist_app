import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/assignedhomeworkpool.dart';

class AssignedHomeworkPoolDataProvider {
  final FirebaseFirestore firestoreInstance;
  final String therapistId;

  AssignedHomeworkPoolDataProvider(
      {required this.firestoreInstance, required this.therapistId});

  Future<QuerySnapshot> getRawAssignedHomeworkPool(
      {required String clientId}) async {
    QuerySnapshot rawAssignedHomeworkPool = await firestoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("clients")
        .doc(clientId)
        .collection("assignedHomework")
        .get();

    return rawAssignedHomeworkPool;
  }
}
