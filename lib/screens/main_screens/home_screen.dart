import 'package:flutter/material.dart';

import 'package:easier_therapist_app/models/homework.dart';
import '../tab_screens/my_clients_tab_screen.dart';
import '../tab_screens/homework_pool_tab_screen.dart';
import '../../components/appBar.dart';
import '../../dialogs/add_new_client_dialog.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Homework> homework = [
    new Homework(title: "Functional Analysis", fields: ["YO", "YE"]),
    new Homework(title: "Second Homework", fields: ["YO", "YE"]),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      key: UniqueKey(),
      length: 2,
      child: Scaffold(
        appBar: EasierAppBar(
          title: "Easier",
          showDialog: showAddClientDialog,
        ),
        body: TabBarView(
          children: [
            MyClientsTabScreen(),
            HomeworkPoolTabScreen(homeworkPool: homework)
          ],
        ),
      ),
    );
  }
}
