part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationInitializedEvent extends RegistrationEvent {}

class RegistrationSendOtpPressedEvent extends RegistrationEvent {
  final String firstName;
  final String lastName;
  final int phoneNumber;
  RegistrationSendOtpPressedEvent(
      {this.firstName, this.lastName, this.phoneNumber});
}

class RegistrationVerifyOtpPressedEvent extends RegistrationEvent {
  final String firstName;
  final String lastName;
  final int phoneNumber;
  final String sessionId;
  final int enteredOtp;
  RegistrationVerifyOtpPressedEvent(
      {this.firstName,
      this.lastName,
      this.phoneNumber,
      this.sessionId,
      this.enteredOtp});
}
