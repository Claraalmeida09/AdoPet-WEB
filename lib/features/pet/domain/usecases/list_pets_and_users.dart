import 'package:adopet/core/error/failure.dart';
import 'package:adopet/core/usecases/usecase.dart';
import 'package:adopet/features/pet/domain/entities/pet_and_users.dart';
import 'package:adopet/features/pet/domain/repositories/pet_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ListPetsAndUsers extends UseCase<List<PetAndUsers>, ListPetsParams> {
  ListPetsAndUsers({
    required this.petRepository,
  });

  final PetRepository petRepository;

  @override
  Future<Either<Failure, List<PetAndUsers>>> call(
    ListPetsParams params,
  ) =>
      petRepository.listPets(status: params.status, type: params.type);
}

class ListPetsParams extends Equatable {
  const ListPetsParams({this.status, this.type});

  final String? status;
  final String? type;

  @override
  List<Object?> get props => [
        status,
      ];
}
