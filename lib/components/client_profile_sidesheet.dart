import 'package:easier_therapist_app/styles/colors_icons.dart';
import 'package:flutter/material.dart';

import '../models/client.dart';
import '../components/floating_button.dart';

class ClientProfileSideSheet extends StatelessWidget {
  ClientProfileSideSheet(
      {required this.client,
      required this.selected,
      required this.onSelectMenuItem});

  final Client client;
  final String selected;
  final Function onSelectMenuItem;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height - 56,
      width: width * 0.2,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    client.name + " " + client.lastName,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize:
                            Theme.of(context).textTheme.headline5?.fontSize),
                  ),
                ),
              ),
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
                  Center(
                    child: SizedBox(
                      height: 48,
                      width: 208,
                      child: FloatingButton(
                        color: MyColors.primary,
                        icon: Icon(Icons.archive_outlined),
                        title: "ARCHIVE CLIENT",
                        action: () => print("archived client"),
                      ),
                    ),
                  ),
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
