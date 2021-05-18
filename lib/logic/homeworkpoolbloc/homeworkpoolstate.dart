import '../../data/models/homeworkpool.dart';

class HomeworkPoolState {
  final HomeworkPool homeworkPool;

  HomeworkPoolState({required this.homeworkPool});
}

class HomeworkPoolDataInit extends HomeworkPoolState {
  HomeworkPoolDataInit({required HomeworkPool homeworkPool})
      : super(homeworkPool: homeworkPool);
}

class HomeworkPoolDataSyncedWithDatabase extends HomeworkPoolState {
  HomeworkPoolDataSyncedWithDatabase({required HomeworkPool homeworkPool})
      : super(homeworkPool: homeworkPool);
}

class HomeworkPoolDisplayError extends HomeworkPoolState {
  final String errorMessage;
  HomeworkPoolDisplayError({required this.errorMessage})
      : super(homeworkPool: HomeworkPool());
}
