part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class Loading extends HomeState {}

class Loaded extends HomeState {
  const Loaded({required this.user});
  final User user;
}

class Empty extends HomeState {}

class Error extends HomeState {
  const Error({
    required this.message,
  });
  final String message;
}
