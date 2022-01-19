part of 'pet_bloc.dart';

abstract class PetEvent extends Equatable {
  const PetEvent();

  @override
  List<Object> get props => [];
}

class CreatePetEvent extends PetEvent {
  const CreatePetEvent({
    required this.petName,
    required this.type,
    required this.description,
  });

  final String petName;
  final String type;
  final String description;
}

class EditedPetEvent extends PetEvent {
  const EditedPetEvent({
    required this.pet,
  });

  final Pet pet;
}

class ListPetsAndUsersEvent extends PetEvent {
  const ListPetsAndUsersEvent({
    this.type,
    this.status,
  });

  final String? type;
  final String? status;
}

class DeletedPetEvent extends PetEvent {
  const DeletedPetEvent({required this.id});

  final int id;
}
