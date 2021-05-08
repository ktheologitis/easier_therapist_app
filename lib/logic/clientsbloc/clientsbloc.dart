import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'clientsevent.dart';
import 'clientsstate.dart';
import '../../data/repositories/clientsRepository.dart';
import '../../data/models/clients.dart';
import '../../data/models/client.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {
  final FirebaseFirestore firestoreInstance;
  final String therapistId;
  static Clients clients = new Clients();
  late ClientsRepository clientsRepository;

  ClientsBloc({required this.firestoreInstance, required this.therapistId})
      : super(ClientsLoading(clients: clients)) {
    clientsRepository = new ClientsRepository(
      fireStoreInstance: firestoreInstance,
      therapistId: therapistId,
      clients: clients,
    );
  }

  @override
  Stream<ClientsState> mapEventToState(ClientsEvent event) async* {
    if (event is ClientsBeingFetched) {
      final Clients clients = await clientsRepository.getClients();
      yield ClientsLoaded(clients: clients);
    } else if (event is ClientAdded) {
      yield* _mapClientAddedEventToState(event);
    }
  }

  Stream<ClientsState> _mapClientAddedEventToState(ClientAdded event) async* {
    final Client newClient = event.client;
    await clientsRepository
        .addnewClientToDatabase(client: newClient)
        .then((value) async* {
      Clients newClients = new Clients();
      newClients.data = {...state.clients.data};
      newClients.data[event.client.id] = newClient;
      yield ClientsLoaded(clients: newClients);
    }).catchError((err) {
      print("Adding new client error: $err");
    });
  }
}
