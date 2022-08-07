
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_perfect_app/common/bloc/pet_registration_bloc/pet_registration_event.dart';
import 'package:pet_perfect_app/common/bloc/pet_registration_bloc/pet_registration_state.dart';
import 'package:pet_perfect_app/repositories/api_repository.dart';

class PetRegistrationBloc
    extends Bloc<PetRegistrationEvent, PetRegistrationState> {
  ApiRepository apiRepository = ApiRepository();
  PetRegistrationBloc() : super(PetRegistrationInitialState()) {
    add(GetPetRegistrationEvent());
  }


  @override
  Stream<PetRegistrationState> mapEventToState(
      PetRegistrationEvent event) async* {
    if (event is GetPetRegistrationEvent) {
      yield PetRegistrationLoadingState();
      try {
        final petRegistrationDetails = await apiRepository.getPetRegistrationDetails();
        yield PetRegistrationLoadedState(petRegistrationDetails: petRegistrationDetails);
      } catch (error) {
        yield PetRegistrationDataFailureState(error: error.message);
      }
    }
  }
}
