import 'package:equatable/equatable.dart';
import 'package:pet_perfect_app/SideBarPages/models/pet_registration.dart';

abstract class PetRegistrationState extends Equatable {
  const PetRegistrationState();

  @override
  List<Object> get props => [];
}

class PetRegistrationLoadingState extends PetRegistrationState {}

class PetRegistrationInitialState extends PetRegistrationState {}

class PetRegistrationLoadedState extends PetRegistrationState {
  PetRegistrationModel petRegistrationDetails;
  PetRegistrationLoadedState({this.petRegistrationDetails});
}

class PetRegistrationDataFailureState extends PetRegistrationState {
  final String error;

  PetRegistrationDataFailureState({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'DataFailure { error: $error }';
}
