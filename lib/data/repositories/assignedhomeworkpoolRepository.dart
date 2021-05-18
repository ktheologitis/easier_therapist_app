import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easier_therapist_app/data/dataproviders/homeworkpoolDataProvider.dart';
import '../dataproviders/assignedhomeworkpoolDataProvider.dart';
import '../models/assignedhomeworkpool.dart';
import '../models/assignedhomework.dart';
import '../../logic/clientsbloc/clientsbloc.dart';
import '../models/homeworkpool.dart';

class AssignedHomeworkPoolRepository {
  final FirebaseFirestore firestoreInstance;
  final String therapistId;
  late AssignedHomeworkPoolDataProvider assignedhomeworkPoolDataProvider;

  AssignedHomeworkPoolRepository({
    required this.firestoreInstance,
    required this.therapistId,
  }) {
    assignedhomeworkPoolDataProvider = AssignedHomeworkPoolDataProvider(
        firestoreInstance: firestoreInstance, therapistId: therapistId);
  }

  Future<AssignedHomeworkPool> getClientAssignedHomeworkPool({
    required String clientId,
    required HomeworkPool homeworkPool,
  }) async {
    QuerySnapshot clientRawAssignedHomeworkPool =
        await assignedhomeworkPoolDataProvider.getClientRawAssignedHomeworkPool(
            clientId: clientId);

    AssignedHomeworkPool assignedHomeworkPool = new AssignedHomeworkPool();
    clientRawAssignedHomeworkPool.docs.isEmpty
        ? assignedHomeworkPool.data = {}
        : clientRawAssignedHomeworkPool.docs.forEach((rawAssignedHomework) {
            print(rawAssignedHomework.data()["referencedHomeworkId"]);
            print(homeworkPool.data.entries);
            assignedHomeworkPool.data[rawAssignedHomework.id] =
                new AssignedHomework.fromCloud(
              id: rawAssignedHomework.id,
              referencedHomeworkId:
                  rawAssignedHomework.data()["referencedHomeworkId"],
              note: rawAssignedHomework.data()["note"],
              homeworkPool: homeworkPool,
            );
          });

    return assignedHomeworkPool;
  }

  Future<void> addAssignedHomework({
    required String clientId,
    required List<AssignedHomework> assignedHomeworks,
  }) async {
    await assignedhomeworkPoolDataProvider.addAssignedHomework(
      clientId: clientId,
      assignedHomeworks: assignedHomeworks,
    );
  }

  Future<void> updateAssignedHomeworkNote({
    required String clientId,
    required String assignedHomeworkId,
    required String updatedNote,
  }) async {
    await assignedhomeworkPoolDataProvider.updateAssignedHomeworkNote(
        clientId: clientId,
        assignedHomeworkId: assignedHomeworkId,
        updatedNote: updatedNote);
  }

  Future<void> removeAssignedHomework({
    required String clientId,
    required String assignedHomeworkId,
  }) async {
    await assignedhomeworkPoolDataProvider.removeAssignedHomework(
        clientId: clientId, assignedHomeworkId: assignedHomeworkId);
  }
}
