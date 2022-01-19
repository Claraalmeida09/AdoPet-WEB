import 'package:adopet/features/pet/domain/entities/pet.dart';

class PetModel extends Pet {
  const PetModel({
    int? id,
    required String petName,
    required String type,
    required String status,
    required String description,
    required int userId,
  }) : super(
          id: id,
          petName: petName,
          type: type,
          status: status,
          description: description,
          userId: userId,
        );

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['id'],
      petName: json['pet_name'],
      type: json['type'],
      status: json['description'],
      description: json['status'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pet_name': petName,
      'type': type,
      'description': description,
      'status': status,
      'user_id': userId,
    };
  }

  static PetModel fromJsonModel(Map<String, dynamic> json) =>
      PetModel.fromJson(json);
}
