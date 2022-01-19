import 'package:adopet/core/error/failure.dart';
import 'package:adopet/core/usecases/usecase.dart';
import 'package:adopet/features/pet/domain/repositories/pet_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class DeletePet extends UseCase<bool, DeletePetParams> {
  DeletePet({
    required this.petRepository,
  });

  final PetRepository petRepository;

  @override
  Future<Either<Failure, bool>> call(
    DeletePetParams params,
  ) =>
      petRepository.deletePet(
        id: params.id,
      );
}

class DeletePetParams extends Equatable {
  const DeletePetParams({
    required this.id,
  });
  final int id;

  @override
  List<Object?> get props => [
        id,
      ];
}
