import 'package:adopet/core/error/failure.dart';
import 'package:adopet/features/user/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, bool>> createUser({
    required User user,
  });

  Future<Either<Failure, bool>> editUser({
    required User user,
  });

  Future<Either<Failure, User?>> getUser(int? id, {bool toCache = true});

  Future<Either<Failure, void>> cacheUser(User user);

  Future<Either<Failure, User?>> getCachedUser();

  Future<Either<Failure, void>> logOut();
}
