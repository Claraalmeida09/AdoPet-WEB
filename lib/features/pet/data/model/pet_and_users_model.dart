import 'package:adopet/features/pet/domain/entities/pet_and_users.dart';

class PetAndUsersModel extends PetAndUsers {
  const PetAndUsersModel({
    int? id,
    required String petName,
    required String type,
    required String status,
    required String description,
    required int userId,
    required String name,
    required String phone,
    required String email,
  }) : super(
          id: id,
          petName: petName,
          type: type,
          status: status,
          description: description,
          userId: userId,
          name: name,
          phone: phone,
          email: email,
        );

  factory PetAndUsersModel.fromJson(Map<String, dynamic> json) {
    return PetAndUsersModel(
      id: json['pet_id'],
      petName: json['pet_name'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      description: json['description'] ?? '',
      userId: json['user_id'],
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pet_id': id,
      'pet_name': petName,
      'type': type,
      'description': description,
      'status': status,
      'user_id': userId,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  static PetAndUsersModel fromJsonModel(Map<String, dynamic> json) =>
      PetAndUsersModel.fromJson(json);
}
