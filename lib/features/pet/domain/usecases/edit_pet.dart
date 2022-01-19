import 'package:adopet/core/error/failure.dart';
import 'package:adopet/core/usecases/usecase.dart';
import 'package:adopet/features/pet/domain/entities/pet.dart';
import 'package:adopet/features/pet/domain/repositories/pet_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class EditPet extends UseCase<bool, PetEditParams> {
  EditPet({
    required this.petRepository,
  });

  final PetRepository petRepository;

  @override
  Future<Either<Failure, bool>> call(
    PetEditParams params,
  ) =>
      petRepository.editPet(
        pet: params.pet,
      );
}

class PetEditParams extends Equatable {
  const PetEditParams({
    required this.pet,
  });
  final Pet pet;

  @override
  List<Object?> get props => [
        pet,
      ];
}
