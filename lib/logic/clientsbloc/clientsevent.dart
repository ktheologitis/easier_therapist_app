import '../../data/models/client.dart';
import '../../data/models/homeworkpool.dart';

class ClientsEvent {}

class ClientsBeingFetched extends ClientsEvent {}

class ClientAdded extends ClientsEvent {
  final Client client;
  ClientAdded({required this.client});
}

class ClientDeleted extends ClientsEvent {
  final String clientId;
  ClientDeleted({required this.clientId});
}

class ClientUpdated extends ClientsEvent {
  ClientUpdated({required this.updatedClient});
  final Client updatedClient;
}

class ClientArchived extends ClientsEvent {
  ClientArchived({required this.clientId});
  final String clientId;
}

class ClientReActivated extends ClientsEvent {
  ClientReActivated({required this.clientId});
  final String clientId;
}

class ClientAssignedHomeworkScreenInit extends ClientsEvent {}

class ClientAssignedHomeworkPoolBeingFetched extends ClientsEvent {
  ClientAssignedHomeworkPoolBeingFetched(
      {required this.clientId, required this.homeworkPool});
  final String clientId;
  final HomeworkPool homeworkPool;
}
