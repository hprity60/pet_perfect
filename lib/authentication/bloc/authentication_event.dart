part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationAppStartEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class AuthenticationRegisterEvent extends AuthenticationEvent {
  final Registration registration;

  const AuthenticationRegisterEvent({@required this.registration});

  @override
  List<Object> get props => [registration];

  @override
  String toString() => 'LoggedIn { user: $registration }';
}

class AuthenticationLogInEvent extends AuthenticationEvent {
  final Registration registration;

  const AuthenticationLogInEvent({@required this.registration});

  @override
  List<Object> get props => [registration];

  @override
  String toString() => 'LoggedIn { user: $registration }';
}

class AuthenticationLogOutEvent extends AuthenticationEvent {}
