import 'package:adopet/core/error/failure.dart';
import 'package:adopet/core/usecases/usecase.dart';
import 'package:adopet/features/login/domain/entities/login.dart';
import 'package:adopet/features/login/domain/repositories/login_repository.dart';
import 'package:adopet/features/user/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class Authentication extends UseCase<User, LoginParams> {
  Authentication({
    required this.loginRepository,
  });

  final LoginRepository loginRepository;

  @override
  Future<Either<Failure, User>> call(
    LoginParams params,
  ) {
    return loginRepository.authentication(
      login: params.login,
    );
  }
}

class LoginParams extends Equatable {
  const LoginParams({
    required this.login,
  });
  final Login login;

  @override
  List<Object?> get props => [
        login,
      ];
}
