import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../../logic/clientsbloc/clientsbarrel.dart';
import '../../data/models/client.dart';

Future<void> showAddClientDialog(BuildContext context) async {
  final width = MediaQuery.of(context).size.width;

  return await showDialog(
      context: context,
      builder: (context) {
        final Uuid uuid = Uuid();
        final _formKey = GlobalKey<FormState>();
        ClientsBloc clientsBloc = BlocProvider.of<ClientsBloc>(context);
        Client newClient = Client(
          id: uuid.v1(),
        );
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text("Add a new client."),
          content: AddNewClientForm(
            width: width,
            formKey: _formKey,
            newClient: newClient,
          ),
          actions: [
            SizedBox(
              height: 36,
              width: 100,
              child: ElevatedButton(
                  child: Text("CLOSE"),
                  onPressed: () => Navigator.of(context).pop()),
            ),
            SizedBox(
              width: 100,
              height: 36,
              child: ElevatedButton(
                child: Text("SAVE"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    clientsBloc.add(ClientAdded(client: newClient));
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        );
      });
}

class AddNewClientForm extends StatefulWidget {
  const AddNewClientForm({
    Key? key,
    required this.width,
    required this.formKey,
    required this.newClient,
  }) : super(key: key);

  final double width;
  final GlobalKey<FormState> formKey;
  final Client newClient;

  @override
  _AddNewClientFormState createState() => _AddNewClientFormState();
}

class _AddNewClientFormState extends State<AddNewClientForm> {
  TextEditingController _dateTimeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SizedBox(
        width: widget.width - (widget.width * 0.2 * 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("The following information can be edited later."),
            SizedBox(height: 24.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: "First Name",
                border: OutlineInputBorder(),
              ),
              onSaved: (value) {
                widget.newClient.firstName = value != null ? value : "";
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please provide a first name";
                }
                return null;
              },
            ),
            SizedBox(height: 24.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Last Name",
                border: OutlineInputBorder(),
              ),
              onSaved: (value) {
                widget.newClient.lastName = value != null ? value : "";
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please provide a last name";
                }
                return null;
              },
            ),
            SizedBox(height: 24.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Phone",
                border: OutlineInputBorder(),
              ),
              onSaved: (value) {
                widget.newClient.phone = value != null ? value : "";
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please provide a phone number";
                }
                return null;
              },
            ),
            SizedBox(height: 24.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Presenting Problem",
                border: OutlineInputBorder(),
              ),
              onSaved: (value) {
                widget.newClient.presentingProblem = value != null ? value : "";
              },
            ),
            SizedBox(height: 24.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: "How did you hear about us?",
                border: OutlineInputBorder(),
              ),
              onSaved: (value) {
                widget.newClient.referencedBy = value != null ? value : "";
              },
            ),
            SizedBox(height: 24.0),
            TextFormField(
              controller: _dateTimeController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon(Icons.date_range_outlined),
                    onPressed: () {
                      showDateTimePicker(
                          context, _dateTimeController, widget.newClient);
                    }),
                labelText: "Session DateTime",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please provide date and time of the first session";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<DateTime?> showDateTimePicker(BuildContext context,
    TextEditingController dateTimeController, Client newClient) {
  return showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(Duration(days: 6 * 30)),
  ).then((date) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((time) {
      print(date);
      print(time);
      if (date != null && time != null) {
        DateTime nextSession = new DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
        newClient.nextSession = nextSession;
        dateTimeController.text =
            DateFormat.yMMMMEEEEd().add_Hm().format(nextSession);
      }
    });
  });
}
