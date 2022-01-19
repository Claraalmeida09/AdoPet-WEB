import 'package:adopet/core/error/failure.dart';
import 'package:adopet/core/usecases/usecase.dart';
import 'package:adopet/features/user/domain/entities/user.dart';
import 'package:adopet/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetUser extends UseCase<User?, GetUserParams> {
  GetUser({
    required this.userRepository,
  });

  final UserRepository userRepository;

  @override
  Future<Either<Failure, User?>> call(
    GetUserParams params,
  ) =>
      userRepository.getUser(params.id, toCache: params.toCache);
}

class GetUserParams extends Equatable {
  const GetUserParams({this.id, this.toCache = true});
  final int? id;
  final bool toCache;

  @override
  List<Object?> get props => [
        id,
      ];
}
