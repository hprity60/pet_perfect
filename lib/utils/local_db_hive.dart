import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pet_perfect_app/registration/models/Registration.dart';

class LocalDb {
  static Box user;
  static Future init() async {
    await Hive.initFlutter();
    user = await Hive.openBox("user");
  }

  static get userFirstName => user.get('firstName');
  static get userLastName => user.get('lastName');
  static get userAuthStatus => user.get('authStatus');
  static get userRefreshToken => user.get('refreshToken');
  static get userPetId => user.get('petId');
  static get userAccessToken => user.get('accessToken');
  static get userPhoneNumber => user.get('phone');
  static get userTokenExpiry => user.get('tokenExpiryS');
  static get userName => user.get("userName");
  static get userImage => user.get("userImage");

  static Future saveUser(Registration userDetails, {String petId}) async {
    await user.put('firstName', userDetails.firstName);
    await user.put('lastName', userDetails.lastName);
    await user.put('authStatus', userDetails.message);
    await user.put('refreshToken', userDetails.refreshToken);
    await user.put('petId', petId);
    await user.put('accessToken', userDetails.accessToken);
    await user.put('phone', userDetails.phoneNumber);
    await user.put('tokenExpiry', userDetails.expires);
  }

  static Future saveInitUserDetails(
      String firstName, String lastName, int phoneNumber) async {
    await user.put('firstName', firstName);
    await user.put('lastName', lastName);
    await user.put('phone', phoneNumber);
  }

  static setUserFirstName(userFirstName) async =>
      await user.put('firstName', userFirstName);
  static setUserLastName(userLastName) async =>
      await user.put('lastName', userLastName);
  static setUserAuthStatus(userAuthStatus) async =>
      await user.put('authStatus', userAuthStatus);
  static setUserRefreshToken(userRefreshToken) async =>
      await user.put('refreshToken', userRefreshToken);
  static setUserPetId(userPetId) async => await user.put('petId', userPetId);
  static setUserAccessToken(userAccessToken) async =>
      await user.put('accessToken', userAccessToken);
  static setUserPhoneNumber(userPhoneNumber) async =>
      await user.put('phone', userPhoneNumber);
  static setUserTokenExpiry(userTokenExpiry) async =>
      await user.put('tokenExpiry', userTokenExpiry);
  static setSideBarInfo(String userName, String userImage) async {
    await user.put('userName', userName);
    await user.put('userImage', userImage);
  }

  static Future clearUserData() async {
    await user.clear();
  }
}
