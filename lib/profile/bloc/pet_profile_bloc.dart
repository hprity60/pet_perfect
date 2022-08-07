import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_perfect_app/profile/models/pet_profile_model.dart';
import 'package:pet_perfect_app/repositories/api_repository.dart';
import 'package:pet_perfect_app/utils/local_db_hive.dart';
import 'package:pet_perfect_app/utils/shared_preferences.dart';

part 'pet_profile_event.dart';
part 'pet_profile_state.dart';

class PetProfileBloc extends Bloc<PetProfileEvent, PetProfileState> {
  PetProfileBloc() : super(PetProfileInitialState()) {
    add(PetProfileInitializedEvent());
  }
  ApiRepository apiRepository = ApiRepository();

  @override
  Stream<PetProfileState> mapEventToState(
    PetProfileEvent event,
  ) async* {
    if (event is PetProfileInitializedEvent) {
      yield PetProfileLoadingState();
      print("hello");
      String phoneNumber = LocalDb.userPhoneNumber.toString();
      try {
        PetProfileModel petProfile =
            await apiRepository.getPetProfileApi(phoneNumber);
        yield PetProfileLoadedState(
          petProfile: petProfile,
        );
      } catch (error) {
        yield PetProfileLoadingFailedState(error: error.toString());
      }
    }
    if (event is PetProfileDataLoadingEvent) {
      yield PetProfileLoadingState();
      yield PetProfileLoadedState(petProfile: event.petProfile);
    }

    if (event is PetProfileEditEvent) {
      yield PetProfileEditState(event.petProfile);
    }
    if (event is PetProfileDataChangedEvent) {
      yield PetProfileDataChangedState(event.petProfile);
    }
  }
}
