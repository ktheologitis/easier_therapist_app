import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'homeworkpoolevent.dart';
import 'homeworkpoolstate.dart';
import '../../data/repositories/homeworkpoolRepository.dart';
import '../../data/models/homeworkpool.dart';
import '../snackbarcubit/snackbarcubit.dart';

class HomeworkPoolBloc extends Bloc<HomeworkPoolEvent, HomeworkPoolState> {
  final FirebaseFirestore firestoreInstance;
  final String therapistId;
  final SnackbarCubit snackbarCubit;
  late HomeworkPoolRepository homeworkPoolRepository;

  HomeworkPoolBloc({
    required this.firestoreInstance,
    required this.therapistId,
    required this.snackbarCubit,
  }) : super(HomeworkPoolLoading(homeworkPool: HomeworkPool())) {
    homeworkPoolRepository = new HomeworkPoolRepository(
      firestoreInstance: firestoreInstance,
      therapistId: therapistId,
    );
  }

  @override
  Stream<HomeworkPoolState> mapEventToState(HomeworkPoolEvent event) async* {
    if (event is HomeworkPoolBeingFetched) {
      yield* _mapHomeworkPoolBeingFetchedEventToState();
    } else if (event is HomeworkAdded) {
      yield* _mapHomeworkAddedEventToState(event);
    } else if (event is HomeworkDeleted) {
      yield* _mapHomeworkDeletedEventToState(event);
    } else if (event is HomeworkUpdated) {
      yield* _mapHomeworkUpdatedEventToState(event);
    }
  }

  Stream<HomeworkPoolState> _mapHomeworkPoolBeingFetchedEventToState() async* {
    try {
      final HomeworkPool homeworkPool =
          await homeworkPoolRepository.getHomeworkPool();
      yield HomeworkPoolDisplay(homeworkPool: homeworkPool);
    } catch (err) {
      print(err);
      snackbarCubit.showSnackbar(
        message: "Error getting homework pool data from cloud.",
        messageType: MessageType.error,
      );
      yield HomeworkPoolDisplayError(
          errorMessage:
              "There was a problem getting your homework pool from the cloud. Please try again.");
    }
  }

  Stream<HomeworkPoolState> _mapHomeworkAddedEventToState(
      HomeworkAdded event) async* {
    try {
      await homeworkPoolRepository.addNewHomeworkToDatabase(
          homework: event.homework);
      state.homeworkPool.data[event.homework.id] = event.homework;
      yield HomeworkPoolDisplay(homeworkPool: state.homeworkPool);
      snackbarCubit.showSnackbar(
        message: "New homework ${event.homework.title} was added.",
        messageType: MessageType.information,
      );
    } catch (err) {
      snackbarCubit.showSnackbar(
        message: "Error adding new homework '${event.homework.title}'",
        messageType: MessageType.error,
      );
      yield HomeworkPoolDisplay(homeworkPool: state.homeworkPool);
    }
  }

  Stream<HomeworkPoolState> _mapHomeworkDeletedEventToState(
      HomeworkDeleted event) async* {
    try {
      homeworkPoolRepository.deleteHomeworkFromDatabase(
          homeworkId: event.homeworkId);
      state.homeworkPool.data.removeWhere((key, _) => key == event.homeworkId);
      yield HomeworkPoolDisplay(homeworkPool: state.homeworkPool);
    } catch (err) {
      snackbarCubit.showSnackbar(
          message: "Error on deleting homework",
          messageType: MessageType.error);
    }
  }

  Stream<HomeworkPoolState> _mapHomeworkUpdatedEventToState(
      HomeworkUpdated event) async* {
    try {
      await homeworkPoolRepository.updateHomeworkInDatabase(
          updatedHomework: event.updatedHomework);
      state.homeworkPool.data[event.updatedHomework.id] = event.updatedHomework;
      snackbarCubit.showSnackbar(
        message: "Homework successfully updated!",
        messageType: MessageType.information,
      );
      yield HomeworkPoolDisplay(homeworkPool: state.homeworkPool);
    } catch (err) {
      print(err);
      snackbarCubit.showSnackbar(
        message: "Error on updating homework in the cloud",
        messageType: MessageType.error,
      );
      yield HomeworkPoolDisplay(homeworkPool: state.homeworkPool);
    }
  }
}
