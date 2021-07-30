import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/clientListItem.dart';
import '../../../logic/clientsbloc/clientsbarrel.dart';
import '../../../data/models/client.dart';
import '../../../logic/filteredclientscubit/filteredclientscubit.dart';

class MyClientsTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    ClientsBloc clientsBloc = BlocProvider.of<ClientsBloc>(context);
    FilteredClientsCubit filteredClientsCubit =
        BlocProvider.of<FilteredClientsCubit>(context);
    TextEditingController _clientFilterController = new TextEditingController();

    return BlocBuilder<ClientsBloc, ClientsState>(builder: (_, state) {
      if (state is ClientsDataSyncedWithDatabase) {
        if (state.clients.data.isEmpty) {
          return Center(
            child: Text("You have not saved any clients yet..."),
          );
        }
        return Padding(
          padding: EdgeInsets.only(
            top: 24.0,
            bottom: 24.0,
            left: width * 0.2,
            right: width * 0.2,
          ),
          child: SizedBox(
            child: Card(
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    TextField(
                        controller: _clientFilterController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            labelText: "Search by Client name"),
                        onChanged: (value) {
                          filteredClientsCubit.filterClients(value);
                        }),
                    Expanded(
                      child: BlocBuilder<FilteredClientsCubit, List<Client>>(
                          builder: (_, state) {
                        return ListView(
                          children: state.map((client) {
                            return ClientListItem(
                              clientId: client.id,
                            );
                          }).toList(),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      } else if (state is ClientsDataInit) {
        clientsBloc.add(ClientsBeingFetched());
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).accentColor,
          ),
        );
      } else {
        return Container(
          height: 0,
          width: 0,
        );
      }
    });
  }
}
