import 'package:equatable/equatable.dart';
import 'package:pet_perfect_app/SideBarPages/models/pet_registration.dart';
import 'package:pet_perfect_app/home/models/deworming.dart';
import 'package:pet_perfect_app/home/models/measurement.dart';
import 'package:pet_perfect_app/home/models/vaccination.dart';
import 'package:pet_perfect_app/screens/Food/models/food.dart';
import '../export.dart';
import '../models/pet_records_and_notes.dart';

abstract class HomeState {
  HomeState();
  PetRecordsAndNotes petRecordsAndNotes;
  TopicsData topicsData;
  PetRegistrationModel petRegistration;
  String parentName;
  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}

class UserDataLoadingState extends HomeState {}

class InitialProfileAddingSuccessfulState extends HomeState {
  final String message;
  InitialProfileAddingSuccessfulState({this.message});
}

class InitialProfileAddingFailedState extends HomeState {
  final String error;
  InitialProfileAddingFailedState({this.error});
}

class SearchButtonPressedState extends HomeState {
  String query;
  SearchButtonPressedState({this.query});

  @override
  List<Object> get props => [query];
}

class NotificationButtonPressedState extends HomeState {}

class EdtingNotesComplete extends HomeState {
  final String note;
  EdtingNotesComplete({this.note});
  @override
  List<Object> get props => [note];
}

class PetRecordsUninitialized extends HomeState {
  final String error;
  PetRecordsUninitialized({this.error});
  @override
  String toString() => 'Pet records are not initialized { error: $error }';
}

class PetRecordsInitialized extends HomeState {}

class PetRecordsAndNotesLoadingState extends HomeState {}

class TopicsDataLoadingState extends HomeState {}

class PetRecordsAndNotesLoadedState extends HomeState {
  PetRecordsAndNotesLoadedState(PetRecordsAndNotes petRecordsAndNotes,
      PetRegistrationModel petRegistration) {
    super.petRecordsAndNotes = petRecordsAndNotes;
    super.petRegistration = petRegistration;
  }

  @override
  List<Object> get props => [petRecordsAndNotes];

  @override
  String toString() =>
      'petRecordsAndNotesLoaded { petRecords: $petRecordsAndNotes }';
}

class TopicsDataLoadedState extends HomeState {
  TopicsDataLoadedState(TopicsData topicsData) {
    super.topicsData = topicsData;
  }

  @override
  List<Object> get props => [topicsData];

  @override
  String toString() => 'TopicDataLoaded { userData: $topicsData }';
}

class DataFailureState extends HomeState {
  final String error;

  DataFailureState({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'DataFailure { error: $error }';
}

class ImportantMessage extends HomeState {
  String message;
  ImportantMessage({this.message});
  @override
  List<Object> get props => [message];
}

class VaccinationState extends HomeState {
  final PetRecordsAndNotes petRecordsAndNotes;
  VaccinationState(this.petRecordsAndNotes);
}

class DewormingDataLoaded extends HomeState {}

class MeasurementState extends HomeState {
  final List<Measurement> measurements;
  MeasurementState(this.measurements);
}

class PictureDataLoading extends HomeState {}

class PictureDataLoaded extends HomeState {
  PictureDataLoaded(PetRecordsAndNotes petRecordsAndNotes) {
    super.petRecordsAndNotes = petRecordsAndNotes;
  }
}

class EditVaccinationState extends HomeState {
  List<Vaccination> vaccinations;
  EditVaccinationState(this.vaccinations);
}

class EditDewormingState extends HomeState {
  List<Deworming> dewormings;
  EditDewormingState(this.dewormings);
}
