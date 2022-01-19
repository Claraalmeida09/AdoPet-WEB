import 'package:adopet/core/error/failure.dart';
import 'package:adopet/core/usecases/usecase.dart';
import 'package:adopet/features/user/domain/repositories/user_repository.dart';
import 'package:adopet/features/user/domain/usecases/user_params.dart';
import 'package:dartz/dartz.dart';

class CreateUser extends UseCase<bool, UserParams> {
  CreateUser({
    required this.userRepository,
  });

  final UserRepository userRepository;

  @override
  Future<Either<Failure, bool>> call(
    UserParams params,
  ) =>
      userRepository.createUser(
        user: params.user,
      );
}
