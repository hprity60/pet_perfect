import 'package:equatable/equatable.dart';

abstract class PetRegistrationEvent extends Equatable {
  const PetRegistrationEvent();

  @override
  List<Object> get props => [];
}

class GetPetRegistrationEvent extends PetRegistrationEvent{}