import 'package:adopet/core/error/exceptions.dart';
import 'package:adopet/core/error/failure.dart';
import 'package:adopet/features/login/data/datasources/login_remote_data_source.dart';
import 'package:adopet/features/login/data/model/login_model.dart';
import 'package:adopet/features/login/domain/entities/login.dart';
import 'package:adopet/features/login/domain/repositories/login_repository.dart';
import 'package:adopet/features/user/data/datasources/user_local_data_source.dart';
import 'package:adopet/features/user/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({
    required this.loginRemoteDataSource,
    required this.userLocalDataSource,
  });

  final LoginRemoteDataSource loginRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;

  @override
  Future<Either<Failure, User>> authentication({
    required Login login,
  }) async {
    try {
      final loginModel = LoginModel(
        username: login.username,
        password: login.password,
      );

      final user = await loginRemoteDataSource.authentication(
        loginModel: loginModel,
      );

      await userLocalDataSource.cacheUser(access: user);

      return Right(user);
    } catch (e) {
      if (e is CheckTheDataException) {
        return Left(
          CheckTheDataFailure(),
        );
      }
      return Left(
        ServerFailure(),
      );
    }
  }
}
