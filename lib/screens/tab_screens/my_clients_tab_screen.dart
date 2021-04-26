import 'package:flutter/material.dart';

import '../../components/client_list_item.dart';
import '../../models/client.dart';

class MyClientsTabScreen extends StatefulWidget {
  // MyClientsTabScreen({this.clientList});

  // final List<String> clientList;

  @override
  _MyClientsTabScreenState createState() => _MyClientsTabScreenState();
}

class _MyClientsTabScreenState extends State<MyClientsTabScreen> {
  final List<Client> clientList = [
    Client(name: "Rick", lastName: "Grimes", phoneNumber: "9"),
    Client(name: "Michone", lastName: "Kiedis", phoneNumber: "9"),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

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
                    children: clientList
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
  }
}
