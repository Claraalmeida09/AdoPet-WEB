import 'package:adopet/core/error/failure.dart';
import 'package:adopet/core/usecases/usecase.dart';
import 'package:adopet/features/user/domain/entities/user.dart';
import 'package:adopet/features/user/domain/usecases/get_cached_user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    this.getCachedUser,
  }) : super(HomeInitial());

  final GetCachedUser? getCachedUser;

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is CheckLoginEvent) {
      yield Loading();

      final failureOrGetCachedUser = await getCachedUser!(NoParams());
      yield failureOrGetCachedUser
          .fold((l) => Error(message: mapFailureToMessage(l)), (r) {
        if (r != null) {
          return Loaded(user: r);
        } else {
          return Empty();
        }
      });
    }
  }
}
