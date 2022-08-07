import 'package:pet_perfect_app/SideBarPages/models/pet_registration.dart';
import 'package:pet_perfect_app/common/bloc/pet_registration_bloc/pet_registration_bloc.dart';
import 'package:pet_perfect_app/common/models/user_data.dart';
import 'package:pet_perfect_app/repositories/api_repository.dart';
import 'package:pet_perfect_app/utils/local_db_hive.dart';

import 'dart:async';
import '../export.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../models/pet_records_and_notes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ApiRepository apiRepository = ApiRepository();

  HomeBloc() : super(PetRecordsAndNotesLoadingState()) {
    add(HomeInitializedEvent());
  }

  HomeState get initialState {
    return PetRecordsAndNotesLoadingState();
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeInitializedEvent) {
      yield PetRecordsAndNotesLoadingState();
      yield TopicsDataLoadingState();
      String petId = LocalDb.userPetId;
      try {
        TopicsData topicData =
            await apiRepository.getTopicsData(petId, LocalDb.userAccessToken);
        yield TopicsDataLoadedState(topicData);
        PetRecordsAndNotes petRecordsAndNotes = await apiRepository
            .getPetRecordsAndNotes(petId, LocalDb.userAccessToken);

        UserData().savePetRecordsAndNotes(
            petRecordsAndNotes); // TODO: HOW TO CHANGE THIS?

        PetRegistrationModel petRegistration =
            await apiRepository.getPetRegistrationDetails();
        LocalDb.setSideBarInfo(
            petRegistration.userName, petRegistration.thumbnail);
        yield PetRecordsAndNotesLoadedState(
            petRecordsAndNotes, petRegistration);
      } catch (error) {
        //yield DataFailureState(error: error.message);
        print(error.toString());
      }
    }
    if (event is VaccinationDataLoadedEvent) {
      yield VaccinationState(event.petRecordsAndNotes);
    }
    if (event is PictureDataLoadedEvent) {
      yield PictureDataLoaded(event.petRecordsAndNotes);
    }
    if (event is EditVaccinationEvent) {
      await apiRepository.saveVaccination(
          event.changedVaccinations, event.petId);
      yield EditVaccinationState(event.vaccinations);
    }
    if (event is EditDewormingEvent) {
      await apiRepository.saveDeworming(event.changedDewormings, event.petId);
      yield EditDewormingState(event.dewormings);
    }
    if (event is MeasurementAddedEvent) {
      try {
        await apiRepository.saveMeasurement({
          "height": event.measurement.height,
          "weight": event.measurement.weight
        }, event.petId);
      } catch (error) {
        yield DataFailureState(error: error.message);
        print(error.toString());
      }
    }
  }
}
