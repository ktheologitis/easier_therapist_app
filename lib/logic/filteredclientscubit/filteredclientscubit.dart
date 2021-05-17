import 'dart:async';

import 'package:bloc/bloc.dart';

import '../clientsbloc/clientsbarrel.dart';
import '../../data/models/clients.dart';
import '../../data/models/client.dart';

class FilteredClientsCubit extends Cubit<List<Client>> {
  final ClientsBloc clientsBloc;
  StreamSubscription? clientsBlocStreamSubscription;

  FilteredClientsCubit({required this.clientsBloc}) : super([]) {
    _subscribeToClientsBloc();
  }

  void filterClients(String typedText) {
    Clients newClients = new Clients();
    newClients.data = {...clientsBloc.state.clients.data};
    List<Client> newClientsList =
        List.from(newClients.data.values.toList().reversed);

    if (typedText.isNotEmpty) {
      newClientsList.retainWhere((client) =>
          client.firstName.toLowerCase().contains(typedText.toLowerCase()) ||
          client.lastName.toLowerCase().contains(typedText.toLowerCase()));
      emit(newClientsList);
    } else {
      emit(List.from(clientsBloc.state.clients.data.values.toList().reversed));
    }
  }

  void _subscribeToClientsBloc() {
    clientsBlocStreamSubscription = clientsBloc.stream.listen((state) {
      if (state is ClientsDataSyncedWithDatabase) {
        emit(
            List.from(clientsBloc.state.clients.data.values.toList().reversed));
      }
    });
  }

  @override
  Future<void> close() async {
    await clientsBlocStreamSubscription?.cancel();
    return super.close();
  }
}
