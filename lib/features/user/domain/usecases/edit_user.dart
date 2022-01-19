import 'package:adopet/core/error/failure.dart';
import 'package:adopet/core/usecases/usecase.dart';
import 'package:adopet/features/user/domain/repositories/user_repository.dart';
import 'package:adopet/features/user/domain/usecases/user_params.dart';
import 'package:dartz/dartz.dart';

class EditUser extends UseCase<bool, UserParams> {
  EditUser({
    required this.userRepository,
  });

  final UserRepository userRepository;

  @override
  Future<Either<Failure, bool>> call(
    UserParams params,
  ) =>
      userRepository.editUser(
        user: params.user,
      );
}
