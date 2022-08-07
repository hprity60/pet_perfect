import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pet_perfect_app/common/models/user_data.dart';
import 'package:pet_perfect_app/registration/models/Registration.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
// import 'package:pet_perfect_app/utils/shared_preferences.dart';
import '../../utils/local_db_hive.dart';
import 'package:pet_perfect_app/logger.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(AuthenticationState initialState) : super(initialState);

  AuthenticationState get initialState => AuthenticationUnintializedState();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationAppStartEvent) {
      print("authToken: ${LocalDb.userFirstName}");

      if (LocalDb.userFirstName == null) {
        yield AuthenticationUnauthenticatedState();
      } else {
        if (LocalDb.userPetId != null) {
          String phoneNumber = LocalDb.userPhoneNumber.toString();
          // String expires = Preferences.getKey(PREFS_KEYS.TOKEN_EXPIRY);
          String expires = LocalDb.userTokenExpiry;
          print("authToken: ${LocalDb.userAccessToken}");
          yield AuthenticationAuthenticatedState(
              user: Registration(
                  accessToken: LocalDb.userAccessToken,
                  phoneNumber:
                      (phoneNumber != null) ? int.parse(phoneNumber) : null,
                  firstName: LocalDb.userFirstName,
                  lastName: LocalDb.userLastName,
                  expires: (expires != null) ? int.parse(expires) : null,
                  message: LocalDb.userAuthStatus,
                  refreshToken: LocalDb.userRefreshToken),
              petId: LocalDb.userPetId);
        } else {
          String phoneNumber = LocalDb.userPhoneNumber;
          String expires = LocalDb.userTokenExpiry;
          yield AuthenticationAuthenticatedPetUnregisteredState(
              user: Registration(
            accessToken: LocalDb.userAccessToken,
            phoneNumber: (phoneNumber != null) ? int.parse(phoneNumber) : null,
            firstName: LocalDb.userFirstName,
            lastName: LocalDb.userLastName,
            expires: (expires != null) ? int.parse(expires) : null,
            message: LocalDb.userAuthStatus,
            refreshToken: LocalDb.userRefreshToken,
          ));
        }
      }
    }

    if (event is AuthenticationLogInEvent) {
      yield AuthenticationLoadingState();
      if (event.registration.accessToken != null)
        await LocalDb.setUserAccessToken(event.registration.accessToken);
      if (event.registration.refreshToken != null)
        await LocalDb.setUserRefreshToken(event.registration.refreshToken);
      await LocalDb.setUserTokenExpiry(event.registration.expires.toString());
      await LocalDb.setUserFirstName(event.registration.firstName);
      await LocalDb.setUserLastName(event.registration.lastName);
      await LocalDb.setUserPhoneNumber(
          event.registration.phoneNumber.toString());
      await LocalDb.setUserAuthStatus(event.registration.message);

      yield AuthenticationAuthenticatedState(user: event.registration);
    }

    if (event is AuthenticationRegisterEvent) {
      yield AuthenticationLoadingState();
      print("prin" + event.registration.accessToken);
      if (event.registration.accessToken != null)
        await LocalDb.setUserAccessToken(event.registration.accessToken);
      if (event.registration.refreshToken != null)
        await LocalDb.setUserRefreshToken(event.registration.refreshToken);
      await LocalDb.setUserTokenExpiry(event.registration.expires.toString());
      await LocalDb.setUserFirstName(event.registration.firstName);
      await LocalDb.setUserLastName(event.registration.lastName);
      await LocalDb.setUserPhoneNumber(
          event.registration.phoneNumber.toString());
      await LocalDb.setUserAuthStatus(event.registration.message);

      yield AuthenticationAuthenticatedPetUnregisteredState(
          user: event.registration);
    }

    if (event is AuthenticationLogOutEvent) {
      try {
        yield AuthenticationLoadingState();

        await LocalDb.clearUserData();

        yield AuthenticationUnauthenticatedState();
      } catch (err) {
        yield AuthenticationErrorState(error: err);
      }
    }
  }
}
