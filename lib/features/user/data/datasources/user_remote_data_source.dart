import 'package:adopet/core/error/exceptions.dart';
import 'package:adopet/core/values/texts_adopet.dart';
import 'package:adopet/features/user/data/model/user_model.dart';
import 'package:dio/dio.dart';

abstract class UserRemoteDataSource {
  Future<bool> createUser({
    required UserModel userModel,
  });

  Future<bool> editUser({
    required UserModel userModel,
  });

  Future<UserModel> getUser({int? id});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl({
    required this.httpClient,
  });

  final Dio httpClient;

  @override
  Future<bool> createUser({
    required UserModel userModel,
  }) async {
    try {
      await httpClient.post(
        '${TextsAdoPet.baseUrl}usuario',
        data: userModel.toMap(),
      );

      return true;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw CheckTheDataException();
      }

      if (e.response?.statusCode == 401) {
        throw AuthorizeException();
      }

      throw ServerException();
    }
  }

  @override
  Future<bool> editUser({required UserModel userModel}) {
    // TODO: implement editUser
    throw UnimplementedError();
  }

  @override
  Future<UserModel> getUser({
    int? id,
  }) async {
    try {
      final response = await httpClient.get(
        '${TextsAdoPet.baseUrl}/usuario/$id',
      );

      // ignore: avoid_dynamic_calls
      final data = response.data['usuario'] as List<dynamic>;
      if (data.isNotEmpty) {
        return UserModel.fromJson(data.first);
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {
        throw UserNotFoundException();
      }

      throw ServerException();
    }
  }
}
