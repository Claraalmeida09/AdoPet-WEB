import 'package:adopet/core/error/failure.dart';
import 'package:adopet/features/pet/domain/entities/pet.dart';
import 'package:adopet/features/pet/domain/entities/pet_and_users.dart';
import 'package:dartz/dartz.dart';

abstract class PetRepository {
  Future<Either<Failure, bool>> registerPet({
    required Pet pet,
  });

  Future<Either<Failure, bool>> editPet({
    required Pet pet,
  });

  Future<Either<Failure, List<PetAndUsers>>> listPets(
      {String? status, String? type});

  Future<Either<Failure, bool>> deletePet({
    required int id,
  });
}
