part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegistrationInitialState extends RegistrationState {}

class RegistrationSendOtpPressedLoadingState extends RegistrationState {}

class RegistrationSendOtpPressedFailedState extends RegistrationState {
  final String error;
  RegistrationSendOtpPressedFailedState({this.error});
}

class RegistrationVerifyOtpState extends RegistrationState {
  final String sessionId;
  final String message;
  RegistrationVerifyOtpState({this.sessionId, this.message});

  @override
  List<Object> get props => [sessionId, message];
}

class RegistrationVerifyOtpPressedLoadingState extends RegistrationState {}

class RegistrationVerifyOtpSuccessfullState extends RegistrationState {}

class RegistrationVerifyOtpPressedFailedState extends RegistrationState {
  final String error;
  RegistrationVerifyOtpPressedFailedState({this.error});
}
