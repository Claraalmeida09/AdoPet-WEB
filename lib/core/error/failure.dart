import 'package:adopet/core/values/texts_adopet.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {}

class CheckTheDataFailure extends Failure {}

class AuthorizeFailure extends Failure {}

class UserNotFoundFailure extends Failure {}

class CacheFailure extends Failure {}

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return TextsAdoPet.serveFailure;
    case CheckTheDataFailure:
      return TextsAdoPet.checkTheDataFailure;
    case AuthorizeFailure:
      return TextsAdoPet.notHavePermission;
    case UserNotFoundFailure:
      return TextsAdoPet.userNotFound;
    case CacheFailure:
      return TextsAdoPet.cacheFailureMsg;
    default:
      return TextsAdoPet.unexpectedFailureMsg;
  }
}
