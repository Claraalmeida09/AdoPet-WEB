import 'package:adopet/core/error/failure.dart';
import 'package:adopet/core/usecases/usecase.dart';
import 'package:adopet/features/pet/domain/repositories/pet_repository.dart';
import 'package:adopet/features/pet/domain/usecases/pet_params.dart';
import 'package:dartz/dartz.dart';

class RegisterPet extends UseCase<bool, PetParams> {
  RegisterPet({
    required this.petRepository,
  });

  final PetRepository petRepository;

  @override
  Future<Either<Failure, bool>> call(
    PetParams params,
  ) =>
      petRepository.registerPet(
        pet: params.pet,
      );
}
