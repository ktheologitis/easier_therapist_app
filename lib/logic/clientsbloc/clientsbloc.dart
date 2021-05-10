import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'clientsevent.dart';
import 'clientsstate.dart';
import '../../data/repositories/clientsRepository.dart';
import '../../data/models/clients.dart';
import '../../data/models/client.dart';
import '../snackbarcubit/snackbarcubit.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {
  final FirebaseFirestore firestoreInstance;
  final String therapistId;
  final SnackbarCubit snackbarCubit;
  late ClientsRepository clientsRepository;

  ClientsBloc({
    required this.firestoreInstance,
    required this.therapistId,
    required this.snackbarCubit,
  }) : super(ClientsLoading(clients: Clients())) {
    clientsRepository = new ClientsRepository(
      fireStoreInstance: firestoreInstance,
      therapistId: therapistId,
      clients: state.clients,
    );
  }

  @override
  Stream<ClientsState> mapEventToState(ClientsEvent event) async* {
    if (event is ClientsBeingFetched) {
      final Clients clients = await clientsRepository.getClients();
      yield ClientsDisplay(clients: clients);
    } else if (event is ClientAdded) {
      yield* _mapClientAddedEventToState(event);
    }
  }

  Stream<ClientsState> _mapClientAddedEventToState(ClientAdded event) async* {
    final Client newClient = event.client;
    try {
      await clientsRepository.addnewClientToDatabase(client: newClient);
      Clients newClients = new Clients();
      newClients.data = {...state.clients.data};
      newClients.data[event.client.id] = newClient;
      yield ClientsDisplay(clients: newClients);
    } catch (err) {
      snackbarCubit.showSnackbar(
        message: "Error adding new client: $err",
        messageType: MessageType.error,
      );
    }
  }
}
