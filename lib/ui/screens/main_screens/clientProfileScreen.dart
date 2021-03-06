import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/appBar.dart';
import '../tab_screens/clientHomeworkTabScreen.dart';
import '../screen_argument_models/clientProfileScreenArguments.dart';
import '../../components/clientProfileSidesheet.dart';
import '../tab_screens/clientBasicInformationTabScreen.dart';
import '../../dialogs/addNewClientDialog.dart';
import '../../../data/models/client.dart';
import '../../../data/models/clients.dart';
import '../../../logic/clientsbloc/clientsbloc.dart';
import '../../../logic/assignedhomeworkpoolbloc/asignedhomeworkpoolbloc.dart';
import '../../../logic/firestoreinstancecubit/firestoreinstancecubit.dart';
import '../../../logic/therapistcubit/therapistcubit.dart';
import '../../../logic/snackbarcubit/snackbarcubit.dart';

class ClientProfileScreen extends StatefulWidget {
  static const routeName = "ClientProfileScreen";

  @override
  _ClientProfileScreenState createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen>
    with SingleTickerProviderStateMixin {
  var _selectedMenuItem = MenuSelection.BasicInformation;

  void _onSelectMenuItem(String selectedChoice) {
    setState(() {
      _selectedMenuItem = selectedChoice;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ClientProfileScreenArguments arg = ModalRoute.of(context)
        ?.settings
        .arguments as ClientProfileScreenArguments;

    final String therapistId =
        BlocProvider.of<TherapistCubit>(context).state.id;
    final FirebaseFirestore firestoreInstance =
        BlocProvider.of<FirestoreInstanceCubit>(context).state;
    final SnackbarCubit snackbarCubit = BlocProvider.of<SnackbarCubit>(context);
    final Clients clients = BlocProvider.of<ClientsBloc>(context).state.clients;
    final Client client = clients.data[arg.clientId]!;

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocProvider<AssignedHomeworkPoolBloc>(
      create: (_) => AssignedHomeworkPoolBloc(
          therapistId: therapistId,
          clientId: client.id,
          firestoreInstance: firestoreInstance,
          snackbarCubit: snackbarCubit),
      child: Scaffold(
        appBar: EasierAppBarAlternative(
          title: "Easier",
          showDialog: showAddClientDialog,
        ),
        body: SizedBox(
          height: height - 56,
          width: width,
          child: Row(
            children: [
              Container(
                width: width * 0.2,
                child: ClientProfileSideSheet(
                    clientId: client.id,
                    selected: _selectedMenuItem,
                    onSelectMenuItem: _onSelectMenuItem),
              ),
              Container(
                width: width - width * 0.2,
                height: height - 56,
                child: _selectedMenuItem == MenuSelection.BasicInformation
                    ? ClientBasicInformationTabScreen(clientId: client.id)
                    : ClientHomeworkTabScreen(clientId: client.id),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuSelection {
  static const BasicInformation = "Basic Information";
  static const ClientHomework = "Client Homework";
}
