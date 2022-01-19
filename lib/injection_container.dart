import 'package:adopet/features/pet/domain/usecases/delete_pet.dart';
import 'package:adopet/features/pet/domain/usecases/edit_pet.dart';
import 'package:adopet/features/pet/domain/usecases/list_pets_and_users.dart';
import 'package:adopet/features/pet/domain/usecases/register_pet.dart';
import 'package:adopet/features/user/domain/usecases/get_cached_user.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/login/data/datasources/login_remote_data_source.dart';
import 'features/login/data/repositories/login_repository_impl.dart';
import 'features/login/domain/repositories/login_repository.dart';
import 'features/login/domain/usecases/authentication.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/pet/data/datasources/pet_remote_data_source.dart';
import 'features/pet/data/repositories/pet_repository_impl.dart';
import 'features/pet/domain/repositories/pet_repository.dart';
import 'features/pet/presentation/bloc/pet_bloc.dart';
import 'features/user/data/datasources/user_local_data_source.dart';
import 'features/user/data/datasources/user_remote_data_source.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/domain/usecases/cache_user.dart';
import 'features/user/domain/usecases/create_user.dart';
import 'features/user/domain/usecases/get_user.dart';
import 'features/user/presentation/bloc/user_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => HomeBloc(
      getCachedUser: sl(),
    ),
  );

  sl.registerFactory(
    () => PetBloc(
      registerPet: sl(),
      getCachedUser: sl(),
    ),
  );

  sl.registerFactory(
    () => UserBloc(
      createUser: sl(),
      editUser: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => ListPetsAndUsers(
      petRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => EditPet(
      petRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => RegisterPet(
      petRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => DeletePet(
      petRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetCachedUser(
      userRepository: sl(),
    ),
  );

  sl.registerLazySingleton<PetRemoteDataSource>(
    () => PetRemoteDataSourceImpl(
      httpClient: sl(),
    ),
  );

  sl.registerLazySingleton<PetRepository>(
    () => PetRepositoryImpl(
      petRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => CreateUser(
      userRepository: sl(),
    ),
  );

  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      httpClient: sl(),
    ),
  );

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      userRemoteDataSource: sl(),
      userLocalDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => CacheUser(
      userRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetUser(
      userRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => LoginBloc(
      authentication: sl(),
      getUser: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => Authentication(
      loginRepository: sl(),
    ),
  );

  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      loginRemoteDataSource: sl(),
      userLocalDataSource: sl(),
    ),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(
    () => sharedPreferences,
  );

  sl.registerLazySingleton(
    () => Dio(),
  );
}
