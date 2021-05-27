import '../../data/models/completedhomeworkpool.dart';

class CompletedHomeworkPoolState {
  final CompletedHomeworkPool completedHomeworkPool;
  CompletedHomeworkPoolState({required this.completedHomeworkPool});
}

class CompletedHomeworkPoolInit extends CompletedHomeworkPoolState {
  CompletedHomeworkPoolInit(
      {required CompletedHomeworkPool completedHomeworkPool})
      : super(completedHomeworkPool: completedHomeworkPool);
}

class CompletedHomeworkPoolSyncedWithDataBase
    extends CompletedHomeworkPoolState {
  CompletedHomeworkPoolSyncedWithDataBase(
      {required CompletedHomeworkPool completedHomeworkPool})
      : super(completedHomeworkPool: completedHomeworkPool);
}
