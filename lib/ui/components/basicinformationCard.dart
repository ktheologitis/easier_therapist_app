import 'package:easier_therapist_app/logic/updateclientcubit/updateclientcubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../styles/colorsIcons.dart';
import '../../data/models/client.dart';
import '../../logic/clientsbloc/clientsbarrel.dart';
import '../../logic/updateclientcubit/updateclientcubit.dart';
import '../components/datetimePicker.dart';

class BasicInformationCard extends StatelessWidget {
  BasicInformationCard(
      {required this.clientId,
      required this.editableClient,
      required this.formKey});

  final String clientId;
  final Client editableClient;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    print("Basic information card rebuilt");
    final width = MediaQuery.of(context).size.width;
    final Client _clientFromState =
        BlocProvider.of<ClientsBloc>(context).state.clients.data[clientId]!;
    final _updateClientCubit = BlocProvider.of<UpdateClientCubit>(context);

    final _firstNameController = new TextEditingController.fromValue(
        TextEditingValue(text: _clientFromState.firstName));
    final _lastNameController = new TextEditingController.fromValue(
        TextEditingValue(text: _clientFromState.lastName));
    final _genderController = new TextEditingController.fromValue(
        TextEditingValue(text: _clientFromState.gender));
    final _ageController = new TextEditingController.fromValue(TextEditingValue(
        text:
            _clientFromState.age == 0 ? "" : _clientFromState.age.toString()));
    final _phoneController = new TextEditingController.fromValue(
        TextEditingValue(text: _clientFromState.phone));
    final _emailController = new TextEditingController.fromValue(
        TextEditingValue(text: _clientFromState.email));
    final _addressController = new TextEditingController.fromValue(
        TextEditingValue(text: _clientFromState.address));
    final _presentingProblemController = new TextEditingController.fromValue(
        TextEditingValue(text: _clientFromState.presentingProblem));
    final _nextSessionController = new TextEditingController.fromValue(
        TextEditingValue(
            text: DateFormat.yMMMMEEEEd()
                .add_Hm()
                .format(_clientFromState.nextSession!)));

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
                height: 40,
                child: Row(
                  children: [
                    Text(
                      "Basic Information",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer()
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
                      .changeUpdateCard(UpdateCardType.basicInformation);
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              fillColor: MyColors.primary.withAlpha(40),
                              filled: true,
                              labelText: "Name",
                            ),
                            onChanged: (value) {
                              editableClient.firstName = value;
                              handleClientDataChange();
                            },
                            onSaved: (_) {
                              editableClient.firstName =
                                  _firstNameController.text;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please provide your client's first name";
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 24.0),
                        Expanded(
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              fillColor: MyColors.primary.withAlpha(40),
                              filled: true,
                              labelText: "Last Name",
                            ),
                            onChanged: (value) {
                              editableClient.lastName = value;
                              handleClientDataChange();
                            },
                            onSaved: (_) {
                              editableClient.lastName =
                                  _lastNameController.text;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please provide your client's last name";
                              }
                            },
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
                            controller: _genderController,
                            decoration: InputDecoration(
                              fillColor: MyColors.primary.withAlpha(40),
                              filled: true,
                              labelText: "Gender",
                            ),
                            onChanged: (value) {
                              editableClient.gender = value;
                              handleClientDataChange();
                            },
                            onSaved: (_) {
                              editableClient.gender = _genderController.text;
                            },
                          ),
                        ),
                        SizedBox(width: 24.0),
                        Expanded(
                          child: TextFormField(
                            controller: _ageController,
                            decoration: InputDecoration(
                              fillColor: MyColors.primary.withAlpha(40),
                              filled: true,
                              labelText: "Age",
                            ),
                            onChanged: (value) {
                              editableClient.age =
                                  value == "" ? 0 : int.parse(value);
                              handleClientDataChange();
                            },
                            onSaved: (_) {
                              final updatedAge =
                                  int.tryParse(_ageController.text);
                              if (updatedAge != null) {
                                editableClient.age = updatedAge;
                              }
                            },
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
                              controller: _phoneController,
                              decoration: InputDecoration(
                                fillColor: MyColors.primary.withAlpha(40),
                                filled: true,
                                labelText: "Phone Number",
                              ),
                              onChanged: (value) {
                                editableClient.phone = value;
                                handleClientDataChange();
                              },
                              onSaved: (_) =>
                                  editableClient.phone = _phoneController.text,
                              validator: (value) {
                                if (value == null ||
                                    int.tryParse(value) == null) {
                                  return "Please provide a valid phone number";
                                }
                              }),
                        ),
                        SizedBox(width: 24.0),
                        Expanded(
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              fillColor: MyColors.primary.withAlpha(40),
                              filled: true,
                              labelText: "Email",
                            ),
                            onChanged: (value) {
                              editableClient.email = value;
                              handleClientDataChange();
                            },
                            onSaved: (_) =>
                                editableClient.email = _emailController.text,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        fillColor: MyColors.primary.withAlpha(40),
                        filled: true,
                        labelText: "Address",
                      ),
                      onChanged: (value) {
                        editableClient.address = value;
                        handleClientDataChange();
                      },
                      onSaved: (_) =>
                          editableClient.address = _addressController.text,
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    TextFormField(
                      controller: _presentingProblemController,
                      decoration: InputDecoration(
                        fillColor: MyColors.primary.withAlpha(40),
                        filled: true,
                        labelText: "Presenting Problem",
                      ),
                      onChanged: (value) {
                        editableClient.presentingProblem = value;
                        handleClientDataChange();
                      },
                      onSaved: (_) => editableClient.presentingProblem =
                          _presentingProblemController.text,
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    TextFormField(
                      controller: _nextSessionController,
                      decoration: InputDecoration(
                        fillColor: MyColors.primary.withAlpha(40),
                        filled: true,
                        labelText: "Next Session",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.date_range_outlined),
                          onPressed: () async {
                            await showDateTimePicker(context,
                                _nextSessionController, editableClient);
                            editableClient.nextSession = DateFormat.yMMMMEEEEd()
                                .add_Hm()
                                .parse(_nextSessionController.text);
                            handleClientDataChange();
                          },
                        ),
                      ),
                      onSaved: (_) => editableClient.nextSession =
                          DateFormat.yMMMMEEEEd()
                              .add_Hm()
                              .parse(_nextSessionController.text),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
