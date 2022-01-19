import 'package:adopet/core/error/failure.dart';
import 'package:adopet/core/usecases/usecase.dart';
import 'package:adopet/core/values/texts_adopet.dart';
import 'package:adopet/features/pet/domain/entities/pet.dart';
import 'package:adopet/features/pet/domain/entities/pet_and_users.dart';
import 'package:adopet/features/pet/domain/usecases/delete_pet.dart';
import 'package:adopet/features/pet/domain/usecases/edit_pet.dart';
import 'package:adopet/features/pet/domain/usecases/list_pets_and_users.dart';
import 'package:adopet/features/pet/domain/usecases/pet_params.dart';
import 'package:adopet/features/pet/domain/usecases/register_pet.dart';
import 'package:adopet/features/user/domain/usecases/cache_user.dart';
import 'package:adopet/features/user/domain/usecases/get_cached_user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pet_event.dart';
part 'pet_state.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  PetBloc({
    this.registerPet,
    this.cacheUser,
    this.getCachedUser,
    this.listPetsAndUsers,
    this.deletePet,
    this.editPet,
  }) : super(PetInitial());

  final RegisterPet? registerPet;
  final CacheUser? cacheUser;
  final GetCachedUser? getCachedUser;
  final ListPetsAndUsers? listPetsAndUsers;
  final DeletePet? deletePet;
  final EditPet? editPet;

  @override
  Stream<PetState> mapEventToState(
    PetEvent event,
  ) async* {
    if (event is CreatePetEvent) {
      yield Loading();

      final failureOrGetCachedUser = await getCachedUser!(NoParams());
      final userId = failureOrGetCachedUser.fold((l) => null, (r) {
        if (r != null) {
          return r.id;
        } else {
          return null;
        }
      });

      if (userId == null) {
        yield const Error(message: TextsAdoPet.notPossibleRegister);
      } else {
        final failureOrCreated = await registerPet!(
          PetParams(
              pet: Pet(
                  petName: event.petName,
                  type: event.type,
                  status: '0',
                  description: event.description,
                  userId: userId)),
        );

        yield failureOrCreated.fold(
          (l) => Error(
              message: mapFailureToMessage(
            l,
          )),
          (r) => Created(),
        );
      }
    } else if (event is ListPetsAndUsersEvent) {
      yield Loading();

      final failureOrList = await listPetsAndUsers!(ListPetsParams(
        type: event.type,
        status: event.status,
      ));

      yield failureOrList.fold(
        (l) => Error(
            message: mapFailureToMessage(
          l,
        )),
        (r) {
          return Loaded(
            list: r,
          );
        },
      );
    } else if (event is DeletedPetEvent) {
      yield Loading();

      final failureOrDeleted = await deletePet!(
        DeletePetParams(
          id: event.id,
        ),
      );

      yield failureOrDeleted.fold(
        (l) => Error(
            message: mapFailureToMessage(
          l,
        )),
        (r) => Deleted(),
      );
    } else if (event is EditedPetEvent) {
      yield Loading();
      final failureOrEdited = await editPet!(
        PetEditParams(
          pet: event.pet,
        ),
      );

      yield failureOrEdited.fold(
        (l) => Error(
            message: mapFailureToMessage(
          l,
        )),
        (r) => Edited(),
      );
    }
  }
}
