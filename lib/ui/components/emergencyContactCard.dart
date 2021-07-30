import 'dart:html';

import 'package:easier_therapist_app/logic/updateclientcubit/updateclientcubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../styles/colorsIcons.dart';
import '../../data/models/client.dart';
import '../../logic/clientsbloc/clientsbarrel.dart';
import '../../logic/updateclientcubit/updateclientcubit.dart';
import '../components/datetimePicker.dart';

class EmergencyContactCard extends StatelessWidget {
  EmergencyContactCard({
    required this.clientId,
    required this.editableClient,
    required this.formKey,
  });
  final String clientId;
  final Client editableClient;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final Client _clientFromState =
        BlocProvider.of<ClientsBloc>(context).state.clients.data[clientId]!;
    final _updateClientCubit = BlocProvider.of<UpdateClientCubit>(context);

    final _emergencyContactFirstNameController =
        TextEditingController.fromValue(
            TextEditingValue(text: _clientFromState.emergencyContactFirstName));
    final _emergencyContactLastNameController = TextEditingController.fromValue(
        TextEditingValue(text: _clientFromState.emergencyContactLastName));
    final _emergencyContactPhoneNumberController =
        TextEditingController.fromValue(TextEditingValue(
            text: _clientFromState.emergencyContactPhoneNumber));
    final _emergencyContactRelationToClientController =
        TextEditingController.fromValue(TextEditingValue(
            text: _clientFromState.emergencyContactRelationToClient));

    void handleClientDataChange() {
      bool areEqual = editableClient.toFirestoreJson().keys.every((key) =>
          editableClient.toFirestoreJson()[key] ==
          _clientFromState.toFirestoreJson()[key]);
      print(areEqual);
      if (_updateClientCubit.state == UpdateClientCubitState.dataNotchanged &&
          areEqual == false) {
        _updateClientCubit.dataChanged();
      } else if (_updateClientCubit.state ==
              UpdateClientCubitState.dataChanged &&
          areEqual == true) {
        _updateClientCubit.noDataChange();
      }
    }

    return SizedBox(
      width: width - width * 0.2,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.0,
                child: Row(
                  children: [
                    Text(
                      "Emergency Contact",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Form(
                key: formKey,
                onChanged: () {
                  _updateClientCubit
                      .changeUpdateCard(UpdateCardType.emergencyContact);
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _emergencyContactFirstNameController,
                            decoration: InputDecoration(
                              fillColor: MyColors.primary.withAlpha(40),
                              filled: true,
                              labelText: "Emergency Contact Name",
                            ),
                            onChanged: (value) {
                              editableClient.emergencyContactFirstName = value;
                              handleClientDataChange();
                            },
                            onSaved: (_) =>
                                editableClient.emergencyContactFirstName =
                                    _emergencyContactFirstNameController.text,
                          ),
                        ),
                        SizedBox(width: 24.0),
                        Expanded(
                          child: TextFormField(
                            controller: _emergencyContactLastNameController,
                            decoration: InputDecoration(
                              fillColor: MyColors.primary.withAlpha(40),
                              filled: true,
                              labelText: "Emergency Contact Last Name",
                            ),
                            onChanged: (value) {
                              editableClient.emergencyContactLastName = value;
                              handleClientDataChange();
                            },
                            onSaved: (_) =>
                                editableClient.emergencyContactLastName =
                                    _emergencyContactLastNameController.text,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _emergencyContactPhoneNumberController,
                            decoration: InputDecoration(
                              fillColor: MyColors.primary.withAlpha(40),
                              filled: true,
                              labelText: "Emergency Contact Phone Number",
                            ),
                            onChanged: (value) {
                              editableClient.emergencyContactPhoneNumber =
                                  value;
                              handleClientDataChange();
                            },
                            onSaved: (_) =>
                                editableClient.emergencyContactPhoneNumber =
                                    _emergencyContactPhoneNumberController.text,
                          ),
                        ),
                        SizedBox(width: 24.0),
                        Expanded(
                          child: TextFormField(
                            controller:
                                _emergencyContactRelationToClientController,
                            decoration: InputDecoration(
                              fillColor: MyColors.primary.withAlpha(40),
                              filled: true,
                              labelText: "Relation with client",
                            ),
                            onChanged: (value) {
                              editableClient.emergencyContactRelationToClient =
                                  value;
                              handleClientDataChange();
                            },
                            onSaved: (_) => editableClient
                                    .emergencyContactRelationToClient =
                                _emergencyContactRelationToClientController
                                    .text,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
