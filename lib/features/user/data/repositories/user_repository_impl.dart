import 'package:adopet/core/error/exceptions.dart';
import 'package:adopet/core/error/failure.dart';
import 'package:adopet/features/user/data/datasources/user_local_data_source.dart';
import 'package:adopet/features/user/data/datasources/user_remote_data_source.dart';
import 'package:adopet/features/user/data/model/user_model.dart';
import 'package:adopet/features/user/domain/entities/user.dart';
import 'package:adopet/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({
    required this.userRemoteDataSource,
    required this.userLocalDataSource,
  });

  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;

  @override
  Future<Either<Failure, bool>> createUser({
    required User user,
  }) async {
    try {
      final userModel = UserModel(
        username: user.username,
        name: user.name,
        email: user.email,
        password: user.password,
        phone: user.phone,
      );

      final success = await userRemoteDataSource.createUser(
        userModel: userModel,
      );

      return Right(
        success,
      );
    } catch (e) {
      if (e is CheckTheDataException) {
        return Left(
          CheckTheDataFailure(),
        );
      }

      if (e is AuthorizeException) {
        return Left(
          AuthorizeFailure(),
        );
      }
      return Left(
        ServerFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> editUser({required User user}) {
    // TODO: implement editUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> cacheUser(User user) async {
    try {
      final userModel = UserModel(
          username: user.username,
          name: user.name,
          email: user.email,
          password: user.password,
          phone: user.phone);

      await userLocalDataSource.cacheUser(access: userModel);

      return Right(null);
    } catch (e) {
      return Left(
        CacheFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, User?>> getUser(int? id, {bool toCache = true}) async {
    try {
      final success = await userRemoteDataSource.getUser(id: id);
      if (toCache) {
        await userLocalDataSource.cacheUser(access: success);
      }

      return Right(
        success,
      );
    } catch (e) {
      if (e is UserNotFoundException) {
        return Left(UserNotFoundFailure());
      }

      return Left(
        ServerFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, User?>> getCachedUser() async {
    try {
      final success = await userLocalDataSource.getCachedUser();

      return Right(
        success,
      );
    } catch (e) {
      if (e is UserNotFoundException) {
        return Left(UserNotFoundFailure());
      }

      return Left(
        ServerFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      final result = await userLocalDataSource.removeAccess();

      return const Right(null);
    } catch (e) {
      return Left(
        CacheFailure(),
      );
    }
  }
}
