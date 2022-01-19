import 'package:adopet/core/error/exceptions.dart';
import 'package:adopet/core/error/failure.dart';
import 'package:adopet/features/pet/data/datasources/pet_remote_data_source.dart';
import 'package:adopet/features/pet/data/model/pet_model.dart';
import 'package:adopet/features/pet/domain/entities/pet.dart';
import 'package:adopet/features/pet/domain/entities/pet_and_users.dart';
import 'package:adopet/features/pet/domain/repositories/pet_repository.dart';
import 'package:dartz/dartz.dart';

class PetRepositoryImpl implements PetRepository {
  PetRepositoryImpl({
    required this.petRemoteDataSource,
  });

  final PetRemoteDataSource petRemoteDataSource;

  @override
  Future<Either<Failure, bool>> registerPet({
    required Pet pet,
  }) async {
    try {
      final petModel = PetModel(
          petName: pet.petName,
          type: pet.type,
          status: pet.status,
          description: pet.description,
          userId: pet.userId);

      final success = await petRemoteDataSource.registerPet(
        petModel: petModel,
      );

      return Right(
        success,
      );
    } catch (e) {
      if (e is CheckTheDataException) {
        return Left(
          CheckTheDataFailure(),
        );
      }

      if (e is AuthorizeException) {
        return Left(
          AuthorizeFailure(),
        );
      }
      return Left(
        ServerFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, List<PetAndUsers>>> listPets(
      {String? status, String? type}) async {
    try {
      final success = await petRemoteDataSource.listPets(
        status: status,
        type: type,
      );

      return Right(
        success,
      );
    } catch (e) {
      if (e is UserNotFoundException) {
        return Left(UserNotFoundFailure());
      }

      return Left(
        ServerFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> deletePet({required int id}) async {
    try {
      final success = await petRemoteDataSource.deletePet(id: id);

      return Right(
        success,
      );
    } catch (e) {
      return Left(
        ServerFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> editPet({required Pet pet}) async {
    try {
      final petModel = PetModel(
        id: pet.id,
        petName: pet.petName,
        description: pet.description,
        status: pet.status,
        type: pet.type,
        userId: pet.userId,
      );

      final success = await petRemoteDataSource.editPet(
        petModel: petModel,
      );

      return Right(
        success,
      );
    } catch (e) {
      if (e is CheckTheDataException) {
        return Left(
          CheckTheDataFailure(),
        );
      }

      if (e is AuthorizeException) {
        return Left(
          AuthorizeFailure(),
        );
      }
      return Left(
        ServerFailure(),
      );
    }
  }
}
