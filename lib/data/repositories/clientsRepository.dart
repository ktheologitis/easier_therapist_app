import 'package:cloud_firestore/cloud_firestore.dart';
import '../dataproviders/clientsDataProvider.dart';
import '../models/clients.dart';
import '../models/client.dart';

class ClientsRepository {
  final FirebaseFirestore fireStoreInstance;
  final String therapistId;
  final Clients clients;
  late ClientsDataProvider clientsDataProvider;

  ClientsRepository(
      {required this.fireStoreInstance,
      required this.therapistId,
      required this.clients}) {
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
        emergencyContactFirstName:
            rawClient.data()["emergencyContact.firstName"],
        emergencyContactLastName: rawClient.data()["emergencyContact.lastName"],
        emergencyContactPhoneNumber: rawClient.data()["emergencyContact.phone"],
        emergencyContactRelationToClient:
            rawClient.data()["emergencyContact.relation"],
        nextSession: rawClient.data()["nextSession"].toDate(),
        runningSessionNumber: rawClient.data()["runningSessionNumber"],
        active: rawClient.data()["active"],
      );
    });
    return clients;
  }

  Future<void> addnewClientToDatabase({required Client client}) async {
    return await clientsDataProvider.addNewClientToDatabase(client: client);
  }
}
