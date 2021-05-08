class Therapist {
  Therapist({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    this.phone,
    this.age,
    this.gender,
    this.photoUrl,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String? phone;
  final int? age;
  final String? gender;
  final String? photoUrl;
}
