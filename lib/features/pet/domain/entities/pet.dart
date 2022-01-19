import 'package:equatable/equatable.dart';

class Pet extends Equatable {
  const Pet(
      {this.id,
      required this.petName,
      required this.type,
      required this.status,
      required this.description,
      required this.userId});

  final int? id;
  final String petName;
  final String type;
  final String status;
  final String description;
  final int userId;

  @override
  List<Object?> get props => [
        id,
        userId,
      ];
}
