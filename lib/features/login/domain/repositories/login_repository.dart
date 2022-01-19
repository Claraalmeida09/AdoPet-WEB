import 'package:adopet/core/error/failure.dart';
import 'package:adopet/features/login/domain/entities/login.dart';
import 'package:adopet/features/user/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Failure, User>> authentication({
    required Login login,
  });
}
