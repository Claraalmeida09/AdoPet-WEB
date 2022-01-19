part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends UserEvent {
  const CreateUserEvent({required this.user});

  final User user;
}

class EditedUserEvent extends UserEvent {
  const EditedUserEvent({
    required this.user,
  });

  final User user;
}
