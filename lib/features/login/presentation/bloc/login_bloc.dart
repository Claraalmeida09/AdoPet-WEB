import 'package:adopet/core/error/failure.dart';
import 'package:adopet/features/login/domain/entities/login.dart';
import 'package:adopet/features/login/domain/usecases/authentication.dart';
import 'package:adopet/features/user/domain/entities/user.dart';
import 'package:adopet/features/user/domain/usecases/get_user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.authentication, this.getUser})
      : super(LoginInitial());
  final Authentication authentication;
  final GetUser? getUser;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is UserAuthenticationEvent) {
      final login = Login(
        username: event.username,
        password: event.password,
      );

      yield Loading();

      final failureOrAuthentication = await authentication(
        LoginParams(
          login: login,
        ),
      );

      yield await failureOrAuthentication.fold(
          (l) => Error(
                  message: mapFailureToMessage(
                l,
              )),
          (r) => Loaded(r));
    }
  }
}
