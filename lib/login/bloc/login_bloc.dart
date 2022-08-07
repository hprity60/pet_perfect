import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_perfect_app/authentication/bloc/authentication_bloc.dart';
import 'package:pet_perfect_app/registration/registration.dart';
import 'package:pet_perfect_app/repositories/repositories.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ApiRepository apiRepository = ApiRepository();

  final AuthenticationBloc authenticationBloc;

  LoginBloc({this.authenticationBloc}) : super(LoginInitialState());

  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginInitializedEvent) {
      yield LoginInitialState();
    }
    if (event is LoginSendOtpPressedEvent) {
      yield LoginSendOtpPressedLoadingState();

      try {
        Authentication auth =
            await apiRepository.loginAuthApi(event.phoneNumber);
        yield LoginVerifyOtpState(
          sessionId: auth.sessionId,
          message: auth.message,
        );
      } catch (error) {
        yield LoginSendOtpPressedFailedState(error: error.toString());
      }
    }

    if (event is LoginVerifyOtpPressedEvent) {
      yield LoginVerifyOtpPressedLoadingState();

      try {
        Registration reg = await apiRepository.loginApi(
            event.phoneNumber, event.sessionId, event.enteredOtp);

        authenticationBloc.add(AuthenticationLogInEvent(registration: reg));
        yield LoginVerifyOtpSuccessfullState();
      } catch (error) {
        yield LoginSendOtpPressedFailedState(error: error.toString());
      }
    } else {
      yield LoginVerifyOtpPressedFailedState(error: 'OTP is not correct');
    }
  }
}
