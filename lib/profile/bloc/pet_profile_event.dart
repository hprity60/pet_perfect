part of 'pet_profile_bloc.dart';

abstract class PetProfileEvent extends Equatable {
  const PetProfileEvent();

  @override
  List<Object> get props => [];
}

class PetProfileInitializedEvent extends PetProfileEvent {}



class PetProfileDataLoadingEvent extends PetProfileEvent{
  PetProfileModel petProfile;
  PetProfileDataLoadingEvent(this.petProfile);
}
class PetProfileEditEvent extends PetProfileEvent {
  PetProfileModel petProfile;
  PetProfileEditEvent(this.petProfile);
}


class PetProfileDataChangedEvent extends PetProfileEvent {
   PetProfileModel petProfile;
  PetProfileDataChangedEvent(this.petProfile); 
}