import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_perfect_app/initial_profile/models/petRegisteredId.dart';
import 'package:pet_perfect_app/repositories/repositories.dart';
import 'package:pet_perfect_app/utils/local_db_hive.dart';
import 'package:pet_perfect_app/utils/shared_preferences.dart';
import 'package:pet_perfect_app/common/models/user_data.dart';

part 'initial_profile_event.dart';
part 'initial_profile_state.dart';

class InitialProfileBloc
    extends Bloc<InitialProfileEvent, InitialProfileState> {
  ApiRepository apiRepository = ApiRepository();

  InitialProfileBloc() : super(InitialProfileIntialState());

  @override
  Stream<InitialProfileState> mapEventToState(
    InitialProfileEvent event,
  ) async* {
    if (event is InitialProfileIntializeEvent) {
      yield InitialProfileIntialState();
    }
    if (event is InitialProfileRegisterPressedEvent) {
      yield InitialProfileLoadingState();
      try {
        PetIdAndMessage initialProfileRegistrationResp =
            await apiRepository.intialPetProfileRegistration(
                event.phoneNumber,
                event.petType,
                event.breed,
                event.birthday,
                event.gender,
                event.image,
                event.petFirstName,
                event.petLastName,
                event.weight,
                event.bloodGroup,
                LocalDb.userAccessToken);
        await LocalDb.setUserPetId(initialProfileRegistrationResp.petId);
        yield InitialProfileAddingSuccessfulState(
          message: initialProfileRegistrationResp.message,
          petId: initialProfileRegistrationResp.petId,
        );
      } catch (error) {
        yield InitialProfileAddingFailedState(error: error.toString());
      }
    }
  }
}
