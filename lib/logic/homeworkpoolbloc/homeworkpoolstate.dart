import '../../data/models/homeworkpool.dart';
import '../../data/models/homework.dart';

class HomeworkPoolState {}

class HomeworkPoolLoading extends HomeworkPoolState {}

class HomeworkPoolLoaded extends HomeworkPoolState {
  final HomeworkPool homeworkPool;

  HomeworkPoolLoaded({required this.homeworkPool});
}
