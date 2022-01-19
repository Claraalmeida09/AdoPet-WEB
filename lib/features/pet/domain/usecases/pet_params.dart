import 'package:adopet/features/pet/domain/entities/pet.dart';
import 'package:equatable/equatable.dart';

class PetParams extends Equatable {
  const PetParams({
    required this.pet,
  });
  final Pet pet;

  @override
  List<Object?> get props => [
        pet,
      ];
}
