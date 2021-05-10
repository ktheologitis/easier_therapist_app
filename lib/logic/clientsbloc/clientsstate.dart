import '../../data/models/clients.dart';

class ClientsState {
  final Clients clients;
  ClientsState({required this.clients});
}

class ClientsDisplay extends ClientsState {
  ClientsDisplay({required Clients clients}) : super(clients: clients);
}

class ClientsLoading extends ClientsState {
  ClientsLoading({required Clients clients}) : super(clients: clients);
}
