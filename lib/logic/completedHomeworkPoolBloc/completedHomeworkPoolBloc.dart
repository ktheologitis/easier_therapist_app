import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './completedHomeworkPoolEvent.dart';
import './completedHomeworkPoolState.dart';
import '../../data/models/completedhomeworkpool.dart';
import '../snackbarcubit/snackbarcubit.dart';
import '../../data/repositories/completedHomeworkPoolRepository.dart';

class CompletedHomeworkPoolBloc
    extends Bloc<CompletedHomeworkPoolEvent, CompletedHomeworkPoolState> {
  final String therapistId;
  final FirebaseFirestore firestoreInstance;
  final SnackbarCubit snackbarCubit;

  late CompletedHomeworkPoolRepository completedHomeworkPoolRepository;
  CompletedHomeworkPoolBloc({
    required this.therapistId,
    required this.firestoreInstance,
    required this.snackbarCubit,
  }) : super(CompletedHomeworkPoolInit(
            completedHomeworkPool: CompletedHomeworkPool())) {
    completedHomeworkPoolRepository = CompletedHomeworkPoolRepository(
      firestoreInstance: firestoreInstance,
      therapistId: therapistId,
    );
  }

  @override
  Stream<CompletedHomeworkPoolState> mapEventToState(
      CompletedHomeworkPoolEvent event) async* {
    if (event is CompletedHomeworkPoolBeingFetched) {
      yield* _mapCompletedHomeworkPoolBeingFetchedEventToState(event);
    }
  }

  Stream<CompletedHomeworkPoolState>
      _mapCompletedHomeworkPoolBeingFetchedEventToState(
          CompletedHomeworkPoolBeingFetched event) async* {
    try {
      final CompletedHomeworkPool completedHomeworkPool =
          await completedHomeworkPoolRepository.getCompletedHomeworkPool(
              clientId: event.clientId);
      yield CompletedHomeworkPoolSyncedWithDataBase(
          completedHomeworkPool: completedHomeworkPool);
    } catch (err) {
      snackbarCubit.showSnackbar(
        message: "Error fetching completed homework of this client",
        messageType: MessageType.error,
      );
      yield CompletedHomeworkPoolSyncedWithDataBase(
          completedHomeworkPool: state.completedHomeworkPool);
    }
  }
}
