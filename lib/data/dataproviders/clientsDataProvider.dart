import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/client.dart';

class ClientsDataProvider {
  final FirebaseFirestore fireStoreInstance;
  final String therapistId;

  ClientsDataProvider(
      {required this.fireStoreInstance, required this.therapistId});

  Future<QuerySnapshot> getRawClients() async {
    QuerySnapshot rawClients = await fireStoreInstance
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
      "emergencyContact": {
        "firstName": client.emergencyContactFirstName,
        "lastName": client.emergencyContactLastName,
        "phone": client.emergencyContactPhoneNumber,
        "relation": client.emergencyContactRelationToClient
      },
      "nextSession": Timestamp.fromDate(client.nextSession!),
      "runningSessionNumber": client.runningSessionNumber,
      "active": client.active,
    });
  }

  Future<void> updateClientInDatabase({required Client updatedClient}) async {
    await fireStoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("clients")
        .doc(updatedClient.id)
        .update(updatedClient.toFirestoreJson());
  }

  Future<void> deleteClientFromDatabase({required String clientId}) async {
    await fireStoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("clients")
        .doc(clientId)
        .delete();
  }

  Future<void> archiveClient({required String clientId}) async {
    await fireStoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("clients")
        .doc(clientId)
        .update({"active": false});
  }

  Future<void> reActivateClient({required String clientId}) async {
    await fireStoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("clients")
        .doc(clientId)
        .update({"active": true});
  }

  Future<QuerySnapshot> getClientRawAssignedHomework(
      {required String clientId}) async {
    QuerySnapshot clientRawAssingedHomework = await fireStoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("clients")
        .doc(clientId)
        .collection("homeworkPool")
        .get();

    return clientRawAssingedHomework;
  }
}
