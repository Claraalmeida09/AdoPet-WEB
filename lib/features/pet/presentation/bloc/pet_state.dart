part of 'pet_bloc.dart';

abstract class PetState extends Equatable {
  const PetState();

  @override
  List<Object> get props => [];
}

class PetInitial extends PetState {}

class Loading extends PetState {}

class Loaded extends PetState {
  const Loaded({required this.list});

  final List<PetAndUsers> list;
}

class Empty extends PetState {}

class Error extends PetState {
  const Error({
    required this.message,
  });
  final String message;
}

class Created extends PetState {}

class Edited extends PetState {}

class Deleted extends PetState {}
