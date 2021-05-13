import '../../data/models/homeworkpool.dart';
import '../../data/models/homework.dart';

class HomeworkPoolState {
  final HomeworkPool homeworkPool;

  HomeworkPoolState({required this.homeworkPool});
}

class HomeworkPoolLoading extends HomeworkPoolState {
  HomeworkPoolLoading({required HomeworkPool homeworkPool})
      : super(homeworkPool: homeworkPool);
}

class HomeworkPoolDisplay extends HomeworkPoolState {
  HomeworkPoolDisplay({required HomeworkPool homeworkPool})
      : super(homeworkPool: homeworkPool);
}

class HomeworkPoolDisplayError extends HomeworkPoolState {
  final String errorMessage;
  HomeworkPoolDisplayError({required this.errorMessage})
      : super(homeworkPool: HomeworkPool());
}
