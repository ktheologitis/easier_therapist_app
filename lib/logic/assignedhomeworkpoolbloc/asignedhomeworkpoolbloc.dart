import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easier_therapist_app/ui/dialogs/add_new_client_dialog.dart';

import './assignedhomeworkpoolevent.dart';
import './assignedhomeworkpoolstate.dart';
import '../../data/models/assignedhomeworkpool.dart';
import '../../data/repositories/assignedhomeworkpoolRepository.dart';
import '../snackbarcubit/snackbarcubit.dart';

class AssignedHomeworkPoolBloc
    extends Bloc<AssignedHomeworkPoolEvent, AssignedHomeworkPoolState> {
  final String therapistId;
  final String clientId;
  final FirebaseFirestore firestoreInstance;
  final SnackbarCubit snackbarCubit;

  late AssignedHomeworkPoolRepository assignedHomeworkPoolRepository;

  AssignedHomeworkPoolBloc({
    required this.therapistId,
    required this.clientId,
    required this.firestoreInstance,
    required this.snackbarCubit,
  }) : super(AssignedHomeworkPoolInit(
          clientId: clientId,
          assignedHomeworkPool: new AssignedHomeworkPool(),
        )) {
    assignedHomeworkPoolRepository = new AssignedHomeworkPoolRepository(
      firestoreInstance: firestoreInstance,
      therapistId: therapistId,
    );
  }

  @override
  Stream<AssignedHomeworkPoolState> mapEventToState(
      AssignedHomeworkPoolEvent event) async* {
    if (event is AssignedHomeworkPoolBeingFetched) {
      yield* _mapAssignedHomeworkPoolBeingFetchedEventToState(event);
    } else if (event is AssignedHomeworkAdded) {
      yield* _mapAssignedHomeworkAddedEventToState(event);
    } else if (event is AssignedHomeworkNoteUpdated) {
      yield* _mapAssignedHomeworkNoteUpdatedEventToState(event);
    } else if (event is AssignedHomeworkRemoved) {
      yield* _mapAssignedHomeworkRemovedEventToState(event);
    }
  }

  Stream<AssignedHomeworkPoolState>
      _mapAssignedHomeworkPoolBeingFetchedEventToState(
          AssignedHomeworkPoolBeingFetched event) async* {
    try {
      AssignedHomeworkPool assignedHomeworkPool =
          await assignedHomeworkPoolRepository.getClientAssignedHomeworkPool(
        clientId: clientId,
        homeworkPool: event.homeworkPool,
      );
      if (assignedHomeworkPool.data.length == 0) {
        state.assignedHomeworkPool.data = {};
        yield AssignedHomeworkPoolSyncedWithDatabase(
            clientId: clientId,
            assignedHomeworkPool: state.assignedHomeworkPool);
      } else {
        yield AssignedHomeworkPoolSyncedWithDatabase(
            clientId: clientId, assignedHomeworkPool: assignedHomeworkPool);
      }
    } catch (err) {
      print(err);
      snackbarCubit.showSnackbar(
        message: "Error getting assigned homework from cloud",
        messageType: MessageType.error,
      );
      yield AssignedHomeworkPoolSyncedWithDatabase(
          clientId: clientId, assignedHomeworkPool: state.assignedHomeworkPool);
    }
  }

  Stream<AssignedHomeworkPoolState> _mapAssignedHomeworkAddedEventToState(
      AssignedHomeworkAdded event) async* {
    try {
      await assignedHomeworkPoolRepository.addAssignedHomework(
        clientId: clientId,
        assignedHomeworks: event.assignedHomeworks,
      );
      event.assignedHomeworks.forEach((assignedHomework) {
        state.assignedHomeworkPool.data[assignedHomework.id] = assignedHomework;
      });
      yield AssignedHomeworkPoolSyncedWithDatabase(
        clientId: clientId,
        assignedHomeworkPool: state.assignedHomeworkPool,
      );
    } catch (err) {
      snackbarCubit.showSnackbar(
        message: "Error adding assigned homework on the cloud.",
        messageType: MessageType.error,
      );
      yield AssignedHomeworkPoolSyncedWithDatabase(
          clientId: clientId, assignedHomeworkPool: state.assignedHomeworkPool);
    }
  }

  Stream<AssignedHomeworkPoolState> _mapAssignedHomeworkNoteUpdatedEventToState(
      AssignedHomeworkNoteUpdated event) async* {
    try {
      await assignedHomeworkPoolRepository.updateAssignedHomeworkNote(
          clientId: clientId,
          assignedHomeworkId: event.assignedHomeworkId,
          updatedNote: event.updatedNote);
      state.assignedHomeworkPool.data[event.assignedHomeworkId]!.note =
          event.updatedNote;
      snackbarCubit.showSnackbar(
          message: "Successfully updated note!",
          messageType: MessageType.information);
      yield AssignedHomeworkPoolSyncedWithDatabase(
          clientId: clientId, assignedHomeworkPool: state.assignedHomeworkPool);
    } catch (err) {
      snackbarCubit.showSnackbar(
          message: "Could not update note on cloud.",
          messageType: MessageType.error);
      yield AssignedHomeworkPoolSyncedWithDatabase(
          clientId: clientId, assignedHomeworkPool: state.assignedHomeworkPool);
    }
  }

  Stream<AssignedHomeworkPoolState> _mapAssignedHomeworkRemovedEventToState(
      AssignedHomeworkRemoved event) async* {
    try {
      await assignedHomeworkPoolRepository.removeAssignedHomework(
          clientId: clientId, assignedHomeworkId: event.assignedHomeworkId);
      state.assignedHomeworkPool.data.remove(event.assignedHomeworkId);
      yield AssignedHomeworkPoolSyncedWithDatabase(
          clientId: clientId, assignedHomeworkPool: state.assignedHomeworkPool);
    } catch (err) {
      snackbarCubit.showSnackbar(
          message: "Error deleting assigned homework from cloud",
          messageType: MessageType.error);
      yield AssignedHomeworkPoolSyncedWithDatabase(
          clientId: clientId, assignedHomeworkPool: state.assignedHomeworkPool);
    }
  }
}
