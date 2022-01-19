import 'package:adopet/core/error/failure.dart';
import 'package:adopet/core/usecases/usecase.dart';
import 'package:adopet/features/user/domain/entities/user.dart';
import 'package:adopet/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetCachedUser extends UseCase<User?, NoParams> {
  GetCachedUser({
    required this.userRepository,
  });

  final UserRepository userRepository;

  @override
  Future<Either<Failure, User?>> call(
    NoParams params,
  ) =>
      userRepository.getCachedUser();
}
