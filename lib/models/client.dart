class Client {
  Client({
    required this.name,
    required this.lastName,
    required this.phoneNumber,
    this.presentingProblem,
    this.gender,
    this.address,
    this.email,
    this.referencedBy,
    this.age,
    this.emergencyContactName,
    this.emergencyContactLastName,
    this.emergencyContactPhoneNumber,
    this.emergencyContactRelationToClient,
    this.nextSession,
    this.completedSessionDates,
  });

  final String name;
  final String lastName;
  final String phoneNumber;
  final String? presentingProblem;
  final String? gender;
  final String? address;
  final String? email;
  final String? referencedBy;
  final int? age;
  final String? emergencyContactName;
  final String? emergencyContactLastName;
  final String? emergencyContactPhoneNumber;
  final String? emergencyContactRelationToClient;
  final DateTime? nextSession;
  final List<DateTime>? completedSessionDates;
  final bool active = true;
}
