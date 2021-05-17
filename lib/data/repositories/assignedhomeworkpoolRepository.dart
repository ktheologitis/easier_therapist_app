import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easier_therapist_app/data/dataproviders/homeworkpoolDataProvider.dart';
import '../dataproviders/assignedhomeworkpoolDataProvider.dart';
import '../models/assignedhomeworkpool.dart';
import '../models/assignedhomework.dart';
import '../../logic/clientsbloc/clientsbloc.dart';

class AssignedHomeworkPoolRepository {
  final FirebaseFirestore firestoreInstance;
  final String therapistId;
  final ClientsBloc clientsBloc;
  late AssignedHomeworkPoolDataProvider assignedhomeworkPoolDataProvider;

  AssignedHomeworkPoolRepository({
    required this.firestoreInstance,
    required this.therapistId,
    required this.clientsBloc,
  }) {
    assignedhomeworkPoolDataProvider = AssignedHomeworkPoolDataProvider(
        firestoreInstance: firestoreInstance, therapistId: therapistId);
  }

  // Future<AssignedHomeworkPool> getHomeworkPool(
  //     {required String clientId}) async {
  //   QuerySnapshot rawAssignedHomeworkPool = await assignedhomeworkPoolDataProvider.getRawAssignedHomeworkPool(
  //       clientId: clientId);

  //   // assignedHomeworkPool.data =

  // }
}
