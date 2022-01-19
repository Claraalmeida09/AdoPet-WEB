import 'package:adopet/core/error/exceptions.dart';
import 'package:adopet/core/values/texts_adopet.dart';
import 'package:adopet/features/login/data/model/login_model.dart';
import 'package:adopet/features/user/data/model/user_model.dart';
import 'package:dio/dio.dart';

abstract class LoginRemoteDataSource {
  Future<UserModel> authentication({
    required LoginModel loginModel,
  });
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  LoginRemoteDataSourceImpl({
    required this.client,
  });

  final Dio client;

  @override
  Future<UserModel> authentication({
    required LoginModel loginModel,
  }) async {
    try {
      final response = await client.post(
        '${TextsAdoPet.baseUrl}login',
        data: loginModel.toMap(),
      );
      return UserModel.fromJson(response.data['usuario']);
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw CheckTheDataException();
      }

      throw ServerException();
    }
  }
}
