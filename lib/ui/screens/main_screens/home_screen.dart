import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../tab_screens/my_clients_tab_screen.dart';
import '../tab_screens/homework_pool_tab_screen.dart';
import '../../components/appBar.dart';
import '../../dialogs/add_new_client_dialog.dart';
import '../../../logic/snackbarcubit/snackbarcubit.dart';
import '../../components/snackbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      key: UniqueKey(),
      length: 2,
      child: Scaffold(
        appBar: EasierAppBar(
          title: title,
          showDialog: showAddClientDialog,
        ),
        body: BlocListener<SnackbarCubit, SnackbarState>(
          listener: (context, state) {
            if (state.show == true) {
              ScaffoldMessenger.of(context).showSnackBar(
                getMyCustomSnackBar(
                    message: state.message, messageType: state.messageType),
              );
            }
          },
          child: TabBarView(
            children: [
              MyClientsTabScreen(),
              HomeworkPoolTabScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
