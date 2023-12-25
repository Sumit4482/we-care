// user_model.dart
class Userr {
  final String email;
  final String password;
  final String name;
  final int age;
  final String gender;
  final double height;
  final double weight;
  final String bloodType;
  final String emergencyContact;

  Userr({
    required this.email,
    required this.password,
    required this.name,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.bloodType,
    required this.emergencyContact,
  });

  // Convert Userr object to a Map
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'bloodType': bloodType,
      'emergencyContact': emergencyContact,
    };
  }

  // Create Userr object from a Map
  factory Userr.fromMap(Map<String, dynamic> map, String documentId) {
    return Userr(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      gender: map['gender'] ?? '',
      height: map['height'] ?? 0,
      weight: map['weight'] ?? 0,
      bloodType: map['bloodType'] ?? '',
      emergencyContact: map['emergencyContact'] ?? '',
    );
  }
}
