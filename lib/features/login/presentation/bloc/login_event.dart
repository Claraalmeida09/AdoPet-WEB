part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class UserAuthenticationEvent extends LoginEvent {
  const UserAuthenticationEvent({
    required this.username,
    required this.password,
    this.id,
  });
  final String username;
  final String password;
  final int? id;
}
