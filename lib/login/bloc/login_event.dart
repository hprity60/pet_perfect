part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginInitializedEvent extends LoginEvent {}

class LoginSendOtpPressedEvent extends LoginEvent {
  final int phoneNumber;
  LoginSendOtpPressedEvent({this.phoneNumber});
}

class LoginVerifyOtpPressedEvent extends LoginEvent {
  final int phoneNumber;
  final String sessionId;
  final int enteredOtp;
  LoginVerifyOtpPressedEvent(
      {this.phoneNumber, this.sessionId, this.enteredOtp});
}
