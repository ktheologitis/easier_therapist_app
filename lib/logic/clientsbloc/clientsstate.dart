import '../../data/models/clients.dart';

class ClientsState {
  final Clients clients;
  ClientsState({required this.clients});
}

class ClientsDataSyncedWithDatabase extends ClientsState {
  ClientsDataSyncedWithDatabase({required Clients clients})
      : super(clients: clients);
}

class ClientsDataLoading extends ClientsState {
  ClientsDataLoading({required Clients clients}) : super(clients: clients);
}
