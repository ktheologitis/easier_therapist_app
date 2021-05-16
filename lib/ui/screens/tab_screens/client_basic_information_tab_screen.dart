import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/basic_information_card.dart';
import '../../components/emergency_contact_card.dart';
import '../../../data/models/client.dart';
import '../../../logic/updateclientcubit/updateclientcubit.dart';
import '../../../logic/clientsbloc/clientsbarrel.dart';

class ClientBasicInformationTabScreen extends StatefulWidget {
  ClientBasicInformationTabScreen({required this.clientId});

  final String clientId;

  @override
  _ClientBasicInformationTabScreenState createState() =>
      _ClientBasicInformationTabScreenState();
}

class _ClientBasicInformationTabScreenState
    extends State<ClientBasicInformationTabScreen> {
  late ClientsBloc clientsBloc;
  late UpdateClientCubit updateClientCubit;
  late Client editableClient;
  late GlobalKey<FormState> basicInformationFormKey;
  late GlobalKey<FormState> emergencyContactFormKey;
  @override
  void initState() {
    super.initState();
    handleLocalState();
  }

  void handleLocalState() {
    clientsBloc = BlocProvider.of<ClientsBloc>(context);
    updateClientCubit = BlocProvider.of<UpdateClientCubit>(context);
    editableClient =
        Client.cloneOf(clientsBloc.state.clients.data[widget.clientId]!);
    basicInformationFormKey = new GlobalKey<FormState>();
    emergencyContactFormKey = new GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Tab screen rebuilt");
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SizedBox(
        height: height - 56,
        child: BlocListener<UpdateClientCubit, UpdateClientCubitState>(
          listener: (_, state) {
            if (state == UpdateClientCubitState.changesSaved) {
              updateClientCubit.reset();
              setState(() {
                handleLocalState();
              });
            } else if (state == UpdateClientCubitState.errorSavingChanges) {
              updateClientCubit.dataChanged();
            }
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BasicInformationCard(
                      clientId: widget.clientId,
                      editableClient: editableClient,
                      formKey: basicInformationFormKey,
                    ),
                    SizedBox(height: 16.0),
                    EmergencyContactCard(
                      clientId: widget.clientId,
                      editableClient: editableClient,
                      formKey: emergencyContactFormKey,
                    ),
                  ],
                ),
              ),
              BlocBuilder<UpdateClientCubit, UpdateClientCubitState>(
                  builder: (_, state) {
                if (state == UpdateClientCubitState.dataChanged) {
                  return Positioned(
                    top: 24,
                    right: 24,
                    child: Container(
                      color: Colors.yellow,
                      child: Row(
                        children: [
                          TextButton.icon(
                            icon: Icon(Icons.done),
                            label: Text("SAVE CHANGES"),
                            onPressed: () {
                              if (basicInformationFormKey.currentState!
                                      .validate() &&
                                  emergencyContactFormKey.currentState!
                                      .validate()) {
                                basicInformationFormKey.currentState!.save();
                                emergencyContactFormKey.currentState!.save();
                                print(editableClient.toFirestoreJson());
                                clientsBloc.add(ClientUpdated(
                                    updatedClient: editableClient));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state == UpdateClientCubitState.savingChanges) {
                  return Positioned(
                    top: 24,
                    right: 24,
                    child: Container(
                      color: Colors.yellow,
                      child: Row(
                        children: [Text("Saving...")],
                      ),
                    ),
                  );
                } else {
                  return Container(
                    height: 0,
                    width: 0,
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
