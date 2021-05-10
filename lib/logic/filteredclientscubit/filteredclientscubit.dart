import 'dart:async';
import 'dart:html';

import 'package:bloc/bloc.dart';

import '../clientsbloc/clientsbarrel.dart';
import '../../data/models/clients.dart';
import '../../data/models/client.dart';

class FilteredClientsCubit extends Cubit<List<Client>> {
  final ClientsBloc clientsBloc;
  StreamSubscription? clientsBlocStreamSubscription;

  FilteredClientsCubit({required this.clientsBloc}) : super([]) {
    _subscribeToClientsBlocUntilClientsAreLoadedForTheFirstTime();
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

  void _subscribeToClientsBlocUntilClientsAreLoadedForTheFirstTime() {
    clientsBlocStreamSubscription = clientsBloc.stream.listen((state) {
      emit(List.from(clientsBloc.state.clients.data.values.toList().reversed));
      if (state is ClientsDisplay) {
        clientsBlocStreamSubscription?.cancel();
      }
    });
  }
}
