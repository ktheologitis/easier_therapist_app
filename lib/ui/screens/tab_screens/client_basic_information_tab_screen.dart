import 'package:flutter/material.dart';

import '../../components/basic_information_card.dart';
import '../../../data/models/client.dart';
import '../../components/emergency_contact_card.dart';

class ClientBasicInformationTabScreen extends StatelessWidget {
  ClientBasicInformationTabScreen({required this.client});

  final Client client;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SizedBox(
        height: height - 56,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BasicInformationCard(),
              SizedBox(height: 16.0),
              EmergencyContactCard(),
            ],
          ),
        ),
      ),
    );
  }
}