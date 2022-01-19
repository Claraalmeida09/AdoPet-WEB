import 'package:adopet/core/error/exceptions.dart';
import 'package:adopet/core/values/texts_adopet.dart';
import 'package:adopet/features/pet/data/model/pet_and_users_model.dart';
import 'package:adopet/features/pet/data/model/pet_model.dart';
import 'package:dio/dio.dart';

abstract class PetRemoteDataSource {
  Future<bool> registerPet({
    required PetModel petModel,
  });

  Future<bool> editPet({
    required PetModel petModel,
  });

  Future<List<PetAndUsersModel>> listPets({
    String? status,
    String? type,
  });

  Future<bool> deletePet({required int id});
}

class PetRemoteDataSourceImpl implements PetRemoteDataSource {
  PetRemoteDataSourceImpl({
    required this.httpClient,
  });

  final Dio httpClient;

  @override
  Future<List<PetAndUsersModel>> listPets({
    String? status,
    String? type,
  }) async {
    try {
      var url = '${TextsAdoPet.baseUrl}pets/user';

      if (type != null) {
        url = url + '/type=$type';
        if (status != null) {
          if (status == '0') {
            url = url + '/status=0';
          } else if (status == '1') {
            url = url + '/status=1';
          }
        }
      } else {
        if (status != null) {
          if (status == '0') {
            url = url + '/status=0';
          } else if (status == '1') {
            url = url + '/status=1';
          }
        }
      }

      final response = await httpClient.get(
        url,
      );

      final data = response.data['pets_users'] as List<dynamic>;

      return data
          .map<PetAndUsersModel>(
              (map) => PetAndUsersModel.fromJson(map as Map<String, dynamic>))
          .toList();
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {
        throw UserNotFoundException();
      }

      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> registerPet({
    required PetModel petModel,
  }) async {
    try {
      await httpClient.post(
        '${TextsAdoPet.baseUrl}pet',
        data: petModel.toMap(),
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
  Future<bool> deletePet({required int id}) async {
    try {
      await httpClient.delete(
        '${TextsAdoPet.baseUrl}pet/$id',
      );

      return true;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> editPet({required PetModel petModel}) async {
    try {
      await httpClient.put(
        '${TextsAdoPet.baseUrl}pet/${petModel.id}',
        data: petModel.toMap(),
      );

      return true;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw CheckTheDataException();
      }

      throw ServerException();
    }
  }
}
