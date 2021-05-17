import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easier_therapist_app/ui/components/client_list_item.dart';

import 'clientsevent.dart';
import 'clientsstate.dart';
import '../../data/repositories/clientsRepository.dart';
import '../../data/models/clients.dart';
import '../../data/models/client.dart';
import '../snackbarcubit/snackbarcubit.dart';
import '../updateclientcubit/updateclientcubit.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {
  final FirebaseFirestore firestoreInstance;
  final String therapistId;
  final SnackbarCubit snackbarCubit;
  final UpdateClientCubit updateClientCubit;
  late ClientsRepository clientsRepository;

  ClientsBloc({
    required this.firestoreInstance,
    required this.therapistId,
    required this.snackbarCubit,
    required this.updateClientCubit,
  }) : super(ClientsDataLoading(clients: Clients())) {
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
      yield ClientsDataSyncedWithDatabase(clients: clients);
    } else if (event is ClientAdded) {
      yield* _mapClientAddedEventToState(event);
    } else if (event is ClientUpdated) {
      yield* _mapClientUpdatedEventToState(event);
    } else if (event is ClientDeleted) {
      yield* _mapClientDeletedEventToState(event);
    } else if (event is ClientArchived) {
      yield* _mapClientArchivedEventToState(event);
    } else if (event is ClientReActivated) {
      yield* _mapClientReActivatedEventToState(event);
    } else if (event is ClientAssignedHomeworkScreenInit) {
      yield ClientsDataLoading(clients: state.clients);
    } else if (event is ClientAssignedHomeworkPoolBeingFetched) {
      yield* _mapClientAssignedHomeworkPoolEventToState(event);
    }
  }

  Stream<ClientsState> _mapClientAddedEventToState(ClientAdded event) async* {
    final Client newClient = event.client;
    try {
      await clientsRepository.addnewClientToDatabase(client: newClient);
      state.clients.data[event.client.id] = newClient;
      snackbarCubit.showSnackbar(
        message:
            "New client ${event.client.firstName} ${event.client.lastName} was added",
        messageType: MessageType.information,
      );
      yield ClientsDataSyncedWithDatabase(clients: state.clients);
    } catch (err) {
      snackbarCubit.showSnackbar(
        message: "Error adding new client: $err",
        messageType: MessageType.error,
      );
    }
  }

  Stream<ClientsState> _mapClientUpdatedEventToState(
      ClientUpdated event) async* {
    try {
      updateClientCubit.savingChangedData();
      await clientsRepository.updateClientInDatabase(
          updatedClient: event.updatedClient);
      state.clients.data[event.updatedClient.id] = event.updatedClient;
      updateClientCubit.changedDataSaved();
      snackbarCubit.showSnackbar(
        message:
            "Successfully updated data for ${event.updatedClient.firstName} ${event.updatedClient.lastName}",
        messageType: MessageType.information,
      );
      yield ClientsDataSyncedWithDatabase(clients: state.clients);
    } catch (err) {
      updateClientCubit.errorSaving();
      snackbarCubit.showSnackbar(
          message: "Error updating client in cloud",
          messageType: MessageType.error);
    }
  }

  Stream<ClientsState> _mapClientDeletedEventToState(
      ClientDeleted event) async* {
    try {
      await clientsRepository.deleteClientFromDatabase(
          clientId: event.clientId);
      state.clients.data.removeWhere((key, _) => key == event.clientId);
      yield ClientsDataSyncedWithDatabase(clients: state.clients);
    } catch (err) {
      updateClientCubit.errorSaving();
      snackbarCubit.showSnackbar(
          message: "Error deleting client from cloud",
          messageType: MessageType.error);
      yield ClientsDataSyncedWithDatabase(clients: state.clients);
    }
  }

  Stream<ClientsState> _mapClientArchivedEventToState(
      ClientArchived event) async* {
    try {
      clientsRepository.archiveClient(clientId: event.clientId);
      state.clients.data[event.clientId]!.active = false;
      yield ClientsDataSyncedWithDatabase(clients: state.clients);
    } catch (err) {
      snackbarCubit.showSnackbar(
        message: "Error changing client status on cloud.",
        messageType: MessageType.error,
      );
      yield ClientsDataSyncedWithDatabase(clients: state.clients);
    }
  }

  Stream<ClientsState> _mapClientReActivatedEventToState(
      ClientReActivated event) async* {
    try {
      clientsRepository.reActivateClient(clientId: event.clientId);
      state.clients.data[event.clientId]!.active = true;
      yield ClientsDataSyncedWithDatabase(clients: state.clients);
    } catch (err) {
      snackbarCubit.showSnackbar(
        message: "Error changing client status on cloud.",
        messageType: MessageType.error,
      );
      yield ClientsDataSyncedWithDatabase(clients: state.clients);
    }
  }

  Stream<ClientsState> _mapClientAssignedHomeworkPoolEventToState(
      ClientAssignedHomeworkPoolBeingFetched event) async* {
    try {
      final assignedHomeworkPool =
          await clientsRepository.getClientAssignedHomeworkPool(
              clientId: event.clientId, homeworkPool: event.homeworkPool);
      state.clients.data[event.clientId]!.assignedHomeworkPool =
          assignedHomeworkPool;
      yield ClientsDataSyncedWithDatabase(clients: state.clients);
    } catch (err) {
      snackbarCubit.showSnackbar(
        message: "Error getting the assigned homework from cloud.",
        messageType: MessageType.error,
      );
      yield ClientsDataSyncedWithDatabase(clients: state.clients);
    }
  }
}
