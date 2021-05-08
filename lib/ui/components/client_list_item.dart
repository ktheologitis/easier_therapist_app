import 'package:flutter/material.dart';

import '../screens/main_screens/client_profile_screen.dart';
import '../../data/models/client.dart';
import '../screens/screen_argument_models/client_profile_screen_arguments.dart';

class ClientListItem extends StatelessWidget {
  ClientListItem({required this.client});

  final Client client;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        print("yeah!");
        Navigator.pushNamed(
          context,
          ClientProfileScreen.routeName,
          arguments: ClientProfileScreenArguments(client: client),
        );
      },
      title: Text(client.firstName + " " + client.lastName),
      subtitle: client.active
          ? Text(
              "Active",
              style: TextStyle(color: Theme.of(context).accentColor),
            )
          : Text("Archived"),
    );
  }
}
