import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/client.dart';

class ClientsDataProvider {
  final FirebaseFirestore fireStoreInstance;
  final String therapistId;

  ClientsDataProvider(
      {required this.fireStoreInstance, required this.therapistId});

  Future<QuerySnapshot> getRawClients() async {
    Future<QuerySnapshot> rawClients = fireStoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("clients")
        .get()
        .catchError((err) {
      print("getting rawClients error: $err");
    });

    return rawClients;
  }

  Future<void> addNewClientToDatabase({required Client client}) async {
    await fireStoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("clients")
        .doc(client.id)
        .set({
      "id": client.id,
      "firstName": client.firstName,
      "lastName": client.lastName,
      "phone": client.phone,
      "email": client.email,
      "address": client.address,
      "age": client.age,
      "gender": client.gender,
      "presentingProblem": client.presentingProblem,
      "referencedBy": client.referencedBy,
      "emergencyContact.firstName": client.emergencyContactFirstName,
      "emergencyContact.lastName": client.emergencyContactLastName,
      "emergencyContact.phone": client.emergencyContactPhoneNumber,
      "emergencyContact.relation": client.emergencyContactRelationToClient,
      "nextSession": Timestamp.fromDate(client.nextSession!),
      "runningSessionNumber": client.runningSessionNumber,
      "active": client.active,
    });
  }
}
