import 'package:adopet/core/error/failure.dart';
import 'package:adopet/core/usecases/usecase.dart';
import 'package:adopet/features/user/domain/entities/user.dart';
import 'package:adopet/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CacheUser extends UseCase<void, CacheParams> {
  CacheUser({
    required this.userRepository,
  });

  final UserRepository userRepository;

  @override
  Future<Either<Failure, void>> call(
    CacheParams params,
  ) {
    return userRepository.cacheUser(params.access);
  }
}

class CacheParams extends Equatable {
  const CacheParams({required this.access});
  final User access;

  @override
  List<Object?> get props => [
        access,
      ];
}
