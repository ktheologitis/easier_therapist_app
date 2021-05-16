import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/main_screens/client_profile_screen.dart';
import '../../data/models/client.dart';
import '../../data/models/clients.dart';
import '../screens/screen_argument_models/client_profile_screen_arguments.dart';
import '../../logic/clientsbloc/clientsbarrel.dart';
import '../styles/colors_icons.dart';

class ClientListItem extends StatelessWidget {
  ClientListItem({required this.clientId});

  final String clientId;

  @override
  Widget build(BuildContext context) {
    final Clients clients = BlocProvider.of<ClientsBloc>(context).state.clients;
    final Client client = clients.data[clientId]!;

    return ListTile(
      onTap: () {
        print("yeah!");
        Navigator.pushNamed(
          context,
          ClientProfileScreen.routeName,
          arguments: ClientProfileScreenArguments(clientId: client.id),
        );
      },
      title: Text(client.firstName + " " + client.lastName),
      subtitle: client.active
          ? Text(
              "Active",
              style: TextStyle(color: Theme.of(context).accentColor),
            )
          : Text(
              "Archived",
              style: TextStyle(color: MyColors.grey),
            ),
    );
  }
}
