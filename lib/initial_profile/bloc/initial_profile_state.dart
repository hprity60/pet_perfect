part of 'initial_profile_bloc.dart';

abstract class InitialProfileState extends Equatable {
  const InitialProfileState();

  @override
  List<Object> get props => [];
}

class InitialProfileIntialState extends InitialProfileState {}

class InitialProfileLoadingState extends InitialProfileState {}

class InitialProfileAddingSuccessfulState extends InitialProfileState {
  final String message;
  final String petId;
  InitialProfileAddingSuccessfulState({this.message, this.petId});
}

class InitialProfileAddingFailedState extends InitialProfileState {
  final String error;
  InitialProfileAddingFailedState({this.error});
}
