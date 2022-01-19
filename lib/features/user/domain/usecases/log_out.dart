import 'package:adopet/core/error/failure.dart';
import 'package:adopet/core/usecases/usecase.dart';
import 'package:adopet/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class LogOut extends UseCase<void, NoParams> {
  LogOut({
    required this.userRepository,
  });

  final UserRepository userRepository;

  @override
  Future<Either<Failure, void>> call(
    NoParams params,
  ) {
    return userRepository.logOut();
  }
}
