import 'dart:convert';

import 'package:adopet/core/error/exceptions.dart';
import 'package:adopet/features/user/data/model/user_model.dart';
import 'package:adopet/features/user/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<void> cacheUser({
    required UserModel access,
  });

  Future<User> getCachedUser();

  Future<bool> removeAccess();
}

const CACHED_USER = 'CACHED_USER';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  const UserLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  Future<void> cacheUser({required UserModel access}) {
    return sharedPreferences.setString(
      CACHED_USER,
      json.encode(access.toMap()),
    );
  }

  @override
  Future<bool> removeAccess() async {
    return await sharedPreferences.remove(CACHED_USER);
  }

  @override
  Future<User> getCachedUser() {
    try {
      final jsonString = json.decode(sharedPreferences.getString(
        CACHED_USER,
      )!);

      return Future.value(
        UserModel.fromCache(jsonString),
      );
    } catch (e) {
      throw CacheException();
    }
  }
}
