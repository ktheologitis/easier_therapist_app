import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/main_screens/clientProfileScreen.dart';
import '../../data/models/client.dart';
import '../../data/models/clients.dart';
import '../screens/screen_argument_models/clientProfileScreenArguments.dart';
import '../../logic/clientsbloc/clientsbarrel.dart';
import '../styles/colorsIcons.dart';
import '../../logic/completedHomeworkPoolBloc/completedHomeworKBarrel.dart';
import '../../logic/showCompletedHomeworkAnswersCubit/showCompletedHomeworkAnswersCubit.dart';

class ClientListItem extends StatelessWidget {
  ClientListItem({required this.clientId});

  final String clientId;

  @override
  Widget build(BuildContext context) {
    final Clients clients = BlocProvider.of<ClientsBloc>(context).state.clients;
    final ShowCompletedHomeworkAnswersCubit showCompletedHomeworkAnswersCubit =
        BlocProvider.of<ShowCompletedHomeworkAnswersCubit>(context);
    final CompletedHomeworkPoolBloc completedHomeworkPoolBloc =
        BlocProvider.of<CompletedHomeworkPoolBloc>(context);

    final Client client = clients.data[clientId]!;

    return ListTile(
      onTap: () {
        completedHomeworkPoolBloc.add(CompletedHomeworkPoolReset());
        showCompletedHomeworkAnswersCubit
            .hideAnswersScreen(); //hide screen answers from another ptreviously chosen client.
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
