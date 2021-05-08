import '../../data/models/client.dart';

class ClientsEvent {}

class ClientsBeingFetched extends ClientsEvent {}

class ClientAdded extends ClientsEvent {
  final Client client;
  ClientAdded({required this.client});
}

class ClientDeleted extends ClientsEvent {}
