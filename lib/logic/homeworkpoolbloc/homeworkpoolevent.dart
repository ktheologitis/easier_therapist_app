import '../../data/models/homework.dart';

class HomeworkPoolEvent {}

class HomeworkPoolBeingFetched extends HomeworkPoolEvent {}

class HomeworkAdded extends HomeworkPoolEvent {
  final Homework homework;
  HomeworkAdded({required this.homework});
}

class HomeworkDeleted extends HomeworkPoolEvent {
  final String homeworkId;
  HomeworkDeleted({required this.homeworkId});
}

class HomeworkUpdated extends HomeworkPoolEvent {
  final Homework updatedHomework;
  HomeworkUpdated({required this.updatedHomework});
}
