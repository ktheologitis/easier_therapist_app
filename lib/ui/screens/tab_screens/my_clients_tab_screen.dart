import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/client_list_item.dart';
import '../../../logic/clientsbloc/clientsbarrel.dart';

class MyClientsTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    ClientsBloc clientsBloc = BlocProvider.of<ClientsBloc>(context);

    return BlocBuilder<ClientsBloc, ClientsState>(builder: (_, state) {
      if (state is ClientsLoaded) {
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
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          // border: OutlineInputBorder(),
                          labelText: "Search by Client name"),
                    ),
                    Expanded(
                      child: ListView(
                        children: state.clients.data.values
                            .map((client) => ClientListItem(
                                  client: client,
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        clientsBloc.add(ClientsBeingFetched());
        return Center(
          child: Text("Loading"),
        );
      }
    });
  }
}
