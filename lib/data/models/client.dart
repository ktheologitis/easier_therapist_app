class Client {
  Client({
    required this.id,
    this.firstName = "",
    this.lastName = "",
    this.phone = "",
    this.presentingProblem = "",
    this.gender = "",
    this.address = "",
    this.email = "",
    this.referencedBy = "",
    this.age = 0,
    this.emergencyContactFirstName = "",
    this.emergencyContactLastName = "",
    this.emergencyContactPhoneNumber = "",
    this.emergencyContactRelationToClient = "",
    this.nextSession,
    this.runningSessionNumber = 0,
    this.active = true,
  });

  final List<String> assignedHomeworkPool = [];
  final List<String> completedHomeworkPool = [];

  final String id;
  String firstName;
  String lastName;
  String phone;
  String? email;
  String? address;
  int? age;
  String? gender;
  String? presentingProblem;
  String? referencedBy;
  String? emergencyContactFirstName;
  String? emergencyContactLastName;
  String? emergencyContactPhoneNumber;
  String? emergencyContactRelationToClient;
  DateTime? nextSession;
  int runningSessionNumber;
  bool active;
}
