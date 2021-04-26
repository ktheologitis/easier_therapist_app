import 'package:flutter/material.dart';

Future<void> showAddClientDialog(BuildContext context) async {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;

  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      title: Text("Add a new client."),
      content: Form(
        child: SizedBox(
          width: width - (width * 0.2 * 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("The following information can be edited later."),
              SizedBox(height: 24.0),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: "First Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24.0),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Last Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24.0),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Phone",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24.0),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Presenting Problem",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24.0),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: "How did you hear about us?",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24.0),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Session DateTime",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
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
              print("yo");
            },
          ),
        ),
      ],
    ),
  );
}
