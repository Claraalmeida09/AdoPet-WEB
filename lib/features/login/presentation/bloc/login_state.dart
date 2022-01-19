part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class Empty extends LoginState {}

class Error extends LoginState {
  const Error({
    required this.message,
  });
  final String message;
}

class Loading extends LoginState {}

class Loaded extends LoginState {
  const Loaded(this.user);

  final User? user;
}
