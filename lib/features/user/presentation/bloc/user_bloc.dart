import 'package:adopet/core/error/failure.dart';
import 'package:adopet/features/user/domain/entities/user.dart';
import 'package:adopet/features/user/domain/usecases/create_user.dart';
import 'package:adopet/features/user/domain/usecases/edit_user.dart';
import 'package:adopet/features/user/domain/usecases/user_params.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    this.createUser,
    this.editUser,
  }) : super(UserInitial());

  final CreateUser? createUser;
  final EditUser? editUser;

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is CreateUserEvent) {
      yield Loading();

      final failureOrCreated = await createUser!(
        UserParams(
          user: event.user,
        ),
      );

      yield failureOrCreated.fold(
        (l) => Error(
            message: mapFailureToMessage(
          l,
        )),
        (r) => Created(),
      );
    }
  }
}
