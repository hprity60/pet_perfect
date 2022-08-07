part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationUnintializedState extends AuthenticationState {}

class AuthenticationAuthenticatedStateWithoutPet extends AuthenticationState {
  final Registration user;
  AuthenticationAuthenticatedStateWithoutPet({this.user});
  @override
  List<Object> get props => [user];
}

class AuthenticationAuthenticatedPetUnregisteredState
    extends AuthenticationState {
  final Registration user;
  AuthenticationAuthenticatedPetUnregisteredState({this.user});
  @override
  List<Object> get props => [user];
}

class AuthenticationAuthenticatedState extends AuthenticationState {
  final String petId;
  final Registration user;
  AuthenticationAuthenticatedState({this.petId, this.user});
  @override
  List<Object> get props => [user];
}

class AuthenticationUnauthenticatedState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationErrorState extends AuthenticationState {
  final String error;

  AuthenticationErrorState({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AuthenticationError { error: $error }';
}
