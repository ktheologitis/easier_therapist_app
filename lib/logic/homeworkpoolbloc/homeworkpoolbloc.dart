import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'homeworkpoolevent.dart';
import 'homeworkpoolstate.dart';
import '../../data/repositories/homeworkpoolRepository.dart';
import '../../data/models/homeworkpool.dart';

class HomeworkPoolBloc extends Bloc<HomeworkPoolEvent, HomeworkPoolState> {
  final FirebaseFirestore firestoreInstance;
  final String therapistId;
  late HomeworkPoolRepository homeworkPoolRepository;

  HomeworkPoolBloc({
    required this.firestoreInstance,
    required this.therapistId,
  }) : super(HomeworkPoolLoading()) {
    homeworkPoolRepository = new HomeworkPoolRepository(
      firestoreInstance: firestoreInstance,
      therapistId: therapistId,
    );
  }

  @override
  Stream<HomeworkPoolState> mapEventToState(HomeworkPoolEvent event) async* {
    if (event is HomeworkPoolBeingFetched) {
      // final HomeworkPool homeworkPool =
      //     await homeworkPoolRepository.getHomeworkPool();
      // yield HomeworkPoolLoaded(homeworkPool: homeworkPool);
    }
  }
}
