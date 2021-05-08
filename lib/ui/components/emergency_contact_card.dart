import 'package:flutter/material.dart';

import '../styles/colors_icons.dart';

class EmergencyContactCard extends StatefulWidget {
  @override
  _EmergencyContactCardState createState() => _EmergencyContactCardState();
}

class _EmergencyContactCardState extends State<EmergencyContactCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width - width * 0.2,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Emergency Contact",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  TextButton.icon(
                    icon: Icon(Icons.undo),
                    label: Text("UNDO CHANGES"),
                    onPressed: () {
                      print("Undo");
                    },
                  ),
                  SizedBox(
                    width: 24.0,
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.check),
                    label: Text("SAVE CHANGES"),
                    onPressed: () {
                      print("Save");
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
              Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: MyColors.primary.withAlpha(40),
                              filled: true,
                              labelText: "Emergency Contact Name",
                            ),
                          ),
                        ),
                        SizedBox(width: 24.0),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: MyColors.primary.withAlpha(40),
                              filled: true,
                              labelText: "Emergency Contact Last Name",
                            ),
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
                            decoration: InputDecoration(
                              fillColor: MyColors.primary.withAlpha(40),
                              filled: true,
                              labelText: "Emergency Contact Phone Number",
                            ),
                          ),
                        ),
                        SizedBox(width: 24.0),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: MyColors.primary.withAlpha(40),
                              filled: true,
                              labelText: "Relation with client",
                            ),
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
