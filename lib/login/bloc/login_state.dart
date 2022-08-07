part of 'login_bloc.dart';

class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginSendOtpPressedLoadingState extends LoginState {}

class LoginSendOtpPressedFailedState extends LoginState {
  final String error;
  LoginSendOtpPressedFailedState({this.error});
}

class LoginVerifyOtpState extends LoginState {
  final String sessionId;
  final String message;
  LoginVerifyOtpState({this.sessionId, this.message});

  @override
  List<Object> get props => [sessionId, message];
}

class LoginVerifyOtpPressedLoadingState extends LoginState {}

class LoginVerifyOtpSuccessfullState extends LoginState {}

class LoginVerifyOtpPressedFailedState extends LoginState {
  final String error;
  LoginVerifyOtpPressedFailedState({this.error});
}
