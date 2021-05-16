import '../../data/models/client.dart';

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
