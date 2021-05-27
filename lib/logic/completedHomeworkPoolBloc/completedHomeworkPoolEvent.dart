class CompletedHomeworkPoolEvent {}

class CompletedHomeworkPoolBeingFetched extends CompletedHomeworkPoolEvent {
  final String clientId;
  CompletedHomeworkPoolBeingFetched({
    required this.clientId,
  });
}
