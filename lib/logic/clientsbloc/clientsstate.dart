import '../../data/models/clients.dart';

class ClientsState {
  final Clients clients;
  ClientsState({required this.clients});
}

class ClientsLoaded extends ClientsState {
  ClientsLoaded({required Clients clients}) : super(clients: clients);
}

class ClientsLoading extends ClientsState {
  ClientsLoading({required Clients clients}) : super(clients: clients);
}
