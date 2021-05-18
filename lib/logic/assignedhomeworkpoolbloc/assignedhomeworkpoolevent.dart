import 'package:easier_therapist_app/data/models/homeworkpool.dart';
import '../../data/models/assignedhomework.dart';

class AssignedHomeworkPoolEvent {
  final String clientId;
  AssignedHomeworkPoolEvent({required this.clientId});
}

class AssignedHomeworkPoolBeingFetched extends AssignedHomeworkPoolEvent {
  final HomeworkPool homeworkPool;
  AssignedHomeworkPoolBeingFetched({
    required String clientId,
    required this.homeworkPool,
  }) : super(clientId: clientId);
}

class AssignedHomeworkAdded extends AssignedHomeworkPoolEvent {
  final List<AssignedHomework> assignedHomeworks;
  AssignedHomeworkAdded({
    required String clientId,
    required this.assignedHomeworks,
  }) : super(clientId: clientId);
}

class AssignedHomeworkRemoved extends AssignedHomeworkPoolEvent {
  final String assignedHomeworkId;
  AssignedHomeworkRemoved(
      {required String clientId, required this.assignedHomeworkId})
      : super(clientId: clientId);
}

class AssignedHomeworkNoteUpdated extends AssignedHomeworkPoolEvent {
  final String updatedNote;
  final String assignedHomeworkId;
  AssignedHomeworkNoteUpdated({
    required String clientId,
    required this.updatedNote,
    required this.assignedHomeworkId,
  }) : super(clientId: clientId);
}
