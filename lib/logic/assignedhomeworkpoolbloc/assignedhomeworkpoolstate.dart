import 'package:easier_therapist_app/data/models/client.dart';

import '../../data/models/assignedhomeworkpool.dart';

class AssignedHomeworkPoolState {
  final String clientId;
  final AssignedHomeworkPool assignedHomeworkPool;

  AssignedHomeworkPoolState(
      {required this.clientId, required this.assignedHomeworkPool});
}

class AssignedHomeworkPoolSyncedWithDatabase extends AssignedHomeworkPoolState {
  AssignedHomeworkPoolSyncedWithDatabase({
    required String clientId,
    required AssignedHomeworkPool assignedHomeworkPool,
  }) : super(clientId: clientId, assignedHomeworkPool: assignedHomeworkPool);
}

class AssignedHomeworkPoolInit extends AssignedHomeworkPoolState {
  AssignedHomeworkPoolInit({
    required String clientId,
    required AssignedHomeworkPool assignedHomeworkPool,
  }) : super(clientId: clientId, assignedHomeworkPool: assignedHomeworkPool);
}
