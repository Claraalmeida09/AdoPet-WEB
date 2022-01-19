import 'package:equatable/equatable.dart';

class PetAndUsers extends Equatable {
  const PetAndUsers({
    this.id,
    required this.petName,
    required this.type,
    required this.status,
    this.description,
    required this.userId,
    required this.name,
    required this.phone,
    required this.email,
  });

  final int? id;
  final String petName;
  final String type;
  final String status;
  final String? description;
  final int userId;
  final String name;
  final String phone;
  final String email;

  @override
  List<Object?> get props => [
        id,
        userId,
      ];

  @override
  String toString() {
    return 'id: $id, petName: $petName, type: $type, status: $status, description: $description, user id: $userId, name: $name, phone: $phone, email: $email';
  }
}
