import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easier_therapist_app/data/models/assignedhomework.dart';
import 'package:easier_therapist_app/data/models/assignedhomeworkpool.dart';
import '../dataproviders/clientsDataProvider.dart';
import '../models/clients.dart';
import '../models/client.dart';
import '../models/homeworkpool.dart';

class ClientsRepository {
  final FirebaseFirestore fireStoreInstance;
  final String therapistId;
  final Clients clients;
  late ClientsDataProvider clientsDataProvider;

  ClientsRepository({
    required this.fireStoreInstance,
    required this.therapistId,
    required this.clients,
  }) {
    clientsDataProvider = ClientsDataProvider(
        fireStoreInstance: fireStoreInstance, therapistId: therapistId);
  }

  Future<Clients> getClients() async {
    final QuerySnapshot rawClients = await clientsDataProvider.getRawClients();
    rawClients.docs.forEach((rawClient) {
      clients.data[rawClient.id] = new Client(
        id: rawClient.id,
        firstName: rawClient.data()["firstName"],
        lastName: rawClient.data()["lastName"],
        phone: rawClient.data()["phone"],
        email: rawClient.data()["email"],
        address: rawClient.data()["address"],
        age: rawClient.data()["age"],
        gender: rawClient.data()["gender"],
        presentingProblem: rawClient.data()["presentingProblem"],
        referencedBy: rawClient.data()["referencedBy"],
        emergencyContactFirstName: rawClient.data()["emergencyContact"]
            ["firstName"],
        emergencyContactLastName: rawClient.data()["emergencyContact"]
            ["lastName"],
        emergencyContactPhoneNumber: rawClient.data()["emergencyContact"]
            ["phone"],
        emergencyContactRelationToClient: rawClient.data()["emergencyContact"]
            ["relation"],
        nextSession: rawClient.data()["nextSession"].toDate(),
        runningSessionNumber: rawClient.data()["runningSessionNumber"],
        active: rawClient.data()["active"],
      );
    });
    return clients;
  }

  Future<void> addnewClientToDatabase({required Client client}) async {
    await clientsDataProvider.addNewClientToDatabase(client: client);
  }

  Future<void> updateClientInDatabase({required Client updatedClient}) async {
    await clientsDataProvider.updateClientInDatabase(
        updatedClient: updatedClient);
  }

  Future<void> deleteClientFromDatabase({required String clientId}) async {
    await clientsDataProvider.deleteClientFromDatabase(clientId: clientId);
  }

  Future<void> archiveClient({required String clientId}) async {
    await clientsDataProvider.archiveClient(clientId: clientId);
  }

  Future<void> reActivateClient({required String clientId}) async {
    await clientsDataProvider.reActivateClient(clientId: clientId);
  }

  Future<AssignedHomeworkPool> getClientAssignedHomeworkPool({
    required String clientId,
    required HomeworkPool homeworkPool,
  }) async {
    QuerySnapshot clientRawAssignedHomeworkPool = await clientsDataProvider
        .getClientRawAssignedHomework(clientId: clientId);

    AssignedHomeworkPool assignedHomeworkPool = new AssignedHomeworkPool();
    clientRawAssignedHomeworkPool.docs.isEmpty
        ? assignedHomeworkPool.data = {}
        : clientRawAssignedHomeworkPool.docs.forEach((rawAssignedHomework) {
            assignedHomeworkPool.data[rawAssignedHomework.id] =
                new AssignedHomework(
              id: rawAssignedHomework.id,
              referencedHomeworkId:
                  rawAssignedHomework.data()["referencedHomeworkId"],
              homeworkPool: homeworkPool,
            );
          });

    return assignedHomeworkPool;
  }
}
