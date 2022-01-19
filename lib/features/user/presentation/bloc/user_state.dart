part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class Loading extends UserState {}

class Loaded extends UserState {}

class Empty extends UserState {}

class Error extends UserState {
  const Error({
    required this.message,
  });
  final String message;
}

class Created extends UserState {}

class Edited extends UserState {}
