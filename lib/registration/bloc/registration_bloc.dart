import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_perfect_app/authentication/authentication.dart';
import 'package:pet_perfect_app/authentication/bloc/authentication_bloc.dart';
import 'package:pet_perfect_app/authentication/models/user.dart';
import 'package:pet_perfect_app/registration/models/Authentication.dart';
import 'package:pet_perfect_app/registration/models/Registration.dart';
import 'package:pet_perfect_app/repositories/repositories.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  ApiRepository apiRepository = ApiRepository();

  final AuthenticationBloc authenticationBloc;

  RegistrationBloc({this.authenticationBloc})
      : super(RegistrationInitialState());

  RegistrationState get initialState => RegistrationInitialState();

  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if (event is RegistrationInitializedEvent) {
      yield RegistrationInitialState();
    }
    if (event is RegistrationSendOtpPressedEvent) {
      yield RegistrationSendOtpPressedLoadingState();

      try {
        Authentication auth =
            await apiRepository.registrationAuthApi(event.phoneNumber);

        yield RegistrationVerifyOtpState(
          sessionId: auth.sessionId,
          message: auth.message,
        );
      } catch (error) {
        yield RegistrationSendOtpPressedFailedState(error: error.toString());
      }
    }

    if (event is RegistrationVerifyOtpPressedEvent) {
      yield RegistrationVerifyOtpPressedLoadingState();

      try {
        var user = fromVars(event.firstName, event.lastName, event.phoneNumber);
        Registration reg = await apiRepository.registrationApi(
            event.sessionId, event.enteredOtp, user);
        reg.populateDetails(event.phoneNumber, event.firstName, event.lastName);

        authenticationBloc.add(AuthenticationRegisterEvent(registration: reg));
        yield RegistrationVerifyOtpSuccessfullState();
      } catch (error) {
        yield RegistrationSendOtpPressedFailedState(error: error.toString());
      }
    }
  }
}
