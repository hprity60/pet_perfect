part of 'pet_profile_bloc.dart';

abstract class PetProfileState extends Equatable {
  const PetProfileState();

  @override
  List<Object> get props => [];
}

class PetProfileInitialState extends PetProfileState {}

class PetProfileLoadingState extends PetProfileState {}

class PetProfileLoadedState extends PetProfileState {
  final PetProfileModel petProfile;
  PetProfileLoadedState({this.petProfile});
}

class PetProfileLoadingFailedState extends PetProfileState {
  final String error;
  PetProfileLoadingFailedState({this.error});
}

class PetProfileDataChangedState extends PetProfileState {
  final PetProfileModel petProfile;
  PetProfileDataChangedState(this.petProfile);
}

class PetProfileEditState extends PetProfileState {
  final PetProfileModel petProfile;
  PetProfileEditState(this.petProfile);
}
