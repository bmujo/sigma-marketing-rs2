class NewProfile {
  String firstName;
  String lastName;
  String email;
  String password;
  String gender;
  DateTime birthDate;
  String phoneNumber;

  NewProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.gender,
    required this.birthDate,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'gender': gender,
      'birthDate': birthDate.toIso8601String(),
      'phoneNumber': phoneNumber,
    };
  }
}