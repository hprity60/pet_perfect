import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pet_perfect_app/home/export.dart';
import 'package:pet_perfect_app/home/models/deworming.dart';
import 'package:pet_perfect_app/home/models/measurement.dart';
import 'package:pet_perfect_app/home/models/vaccination.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

class HomeInitializedEvent extends HomeEvent {}

class NotificationButtonPressed extends HomeEvent {}

class NotesAreaPressed extends HomeEvent {
  final String note;
  NotesAreaPressed({
    this.note,
  });
}

class GetSearchResults extends HomeEvent {
  final String query;
  GetSearchResults({
    this.query,
  });
}

class VaccinationDataLoadedEvent extends HomeEvent {
  PetRecordsAndNotes petRecordsAndNotes;
  VaccinationDataLoadedEvent(this.petRecordsAndNotes);
}

class DewormingDataLoadedEvent extends HomeEvent {}

class MeasurementDataLoadedEvent extends HomeEvent {}

class PictureDataLoadedEvent extends HomeEvent {
  PetRecordsAndNotes petRecordsAndNotes;
  PictureDataLoadedEvent({this.petRecordsAndNotes});
}

class EditVaccinationEvent extends HomeEvent {
  final List<Vaccination> vaccinations;
  final List<Map> changedVaccinations;
  final String petId;
  EditVaccinationEvent(this.vaccinations, this.changedVaccinations, this.petId);
}

class EditDewormingEvent extends HomeEvent {
  final List<Deworming> dewormings;
  final List<Map> changedDewormings;
  final String petId;
  EditDewormingEvent(this.dewormings, this.changedDewormings, this.petId);
}

class MeasurementAddedEvent extends HomeEvent {
  final Measurement measurement;
  final String petId;
  MeasurementAddedEvent(this.measurement, this.petId);
}
