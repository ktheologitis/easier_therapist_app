import 'package:easier_therapist_app/styles/colors_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BasicInformationCard extends StatefulWidget {
  @override
  _BasicInformationCardState createState() => _BasicInformationCardState();
}

class _BasicInformationCardState extends State<BasicInformationCard> {
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
                    "Basic Information",
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
                              labelText: "Name",
                            ),
                          ),
                        ),
                        SizedBox(width: 24.0),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: MyColors.primary.withAlpha(40),
                              filled: true,
                              labelText: "Last Name",
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
                              labelText: "Gender",
                            ),
                          ),
                        ),
                        SizedBox(width: 24.0),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: MyColors.primary.withAlpha(40),
                              filled: true,
                              labelText: "Age",
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
                              labelText: "Phone Number",
                            ),
                          ),
                        ),
                        SizedBox(width: 24.0),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: MyColors.primary.withAlpha(40),
                              filled: true,
                              labelText: "Email",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: MyColors.primary.withAlpha(40),
                        filled: true,
                        labelText: "Address",
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: MyColors.primary.withAlpha(40),
                        filled: true,
                        labelText: "Presenting Problem",
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: MyColors.primary.withAlpha(40),
                        filled: true,
                        labelText: "Next Session",
                      ),
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
