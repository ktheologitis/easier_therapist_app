import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../styles/colorsIcons.dart';
import '../../data/models/client.dart';
import '../../data/models/clients.dart';
import 'floatingButton.dart';
import '../../logic/clientsbloc/clientsbarrel.dart';
import '../dialogs/verifyActionDialog.dart';

class ClientProfileSideSheet extends StatelessWidget {
  ClientProfileSideSheet(
      {required this.clientId,
      required this.selected,
      required this.onSelectMenuItem});

  final String clientId;
  final String selected;
  final Function onSelectMenuItem;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final ClientsBloc clientsBloc = BlocProvider.of<ClientsBloc>(context);
    final Clients clients = clientsBloc.state.clients;
    final Client client = clients.data[clientId]!;

    void handleDeleteClient() {
      clientsBloc.add(ClientDeleted(clientId: client.id));
      Navigator.of(context).popUntil(ModalRoute.withName("/"));
    }

    return SizedBox(
      height: height - 56,
      width: width * 0.2,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    client.firstName + " " + client.lastName,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize:
                            Theme.of(context).textTheme.headline5?.fontSize),
                  ),
                ),
              ),
            ),
            BlocBuilder<ClientsBloc, ClientsState>(
              builder: (_, state) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    state.clients.data[clientId]!.active == true
                        ? "Active"
                        : "Archived",
                    style: state.clients.data[clientId]!.active == true
                        ? TextStyle(color: MyColors.secondary, fontSize: 16)
                        : TextStyle(color: MyColors.grey, fontSize: 16),
                  ),
                );
              },
            ),
            Divider(),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width * 0.2,
                    height: 56,
                    child: InkWell(
                      onTap: () {
                        onSelectMenuItem("Basic Information");
                      },
                      child: Container(
                        color: selected == "Basic Information"
                            ? MyColors.secondary.withOpacity(0.4)
                            : Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Icon(
                                Icons.perm_contact_calendar,
                                color: MyColors.primary,
                              ),
                            ),
                            SizedBox(width: 24),
                            Text(
                              "Basic Information",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.2,
                    height: 56,
                    child: InkWell(
                      onTap: () {
                        onSelectMenuItem("Client Homework");
                      },
                      child: Container(
                        color: selected == "Client Homework"
                            ? MyColors.secondary.withOpacity(0.4)
                            : Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Icon(
                                Icons.rate_review,
                                color: MyColors.primary,
                              ),
                            ),
                            SizedBox(width: 24),
                            Text(
                              "Client Homework",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  BlocBuilder<ClientsBloc, ClientsState>(builder: (_, state) {
                    return Center(
                      child: SizedBox(
                          height: 48,
                          width:
                              state.clients.data[clientId]!.active ? 208 : 240,
                          child: state.clients.data[clientId]!.active == true
                              ? FloatingButton(
                                  color: MyColors.primary,
                                  icon: Icon(Icons.archive_outlined),
                                  title: "ARCHIVE CLIENT",
                                  action: () => clientsBloc
                                      .add(ClientArchived(clientId: clientId)),
                                )
                              : FloatingButton(
                                  color: MyColors.secondary,
                                  icon: Icon(
                                      Icons.settings_backup_restore_rounded),
                                  title: "RE-ACTIVATE CLIENT",
                                  action: () => clientsBloc.add(
                                      ClientReActivated(clientId: clientId)),
                                )),
                    );
                  }),
                  SizedBox(
                    height: 24,
                  ),
                  TextButton.icon(
                    style: ButtonStyle(foregroundColor:
                        MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return MyColors.alertColor;
                        }
                        return MyColors
                            .alertColor; // Use the component's default.
                      },
                    )),
                    onPressed: () {
                      showVerifyActionDialog(
                        context: context,
                        title: "Delete client?",
                        content:
                            "By deleting this clients you are losign all their data forever.",
                        action: handleDeleteClient,
                      );
                      print("Delete client");
                    },
                    icon: Icon(Icons.delete_forever_outlined),
                    label: Text("DELETE CLIENT"),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
