// import 'dart:convert';

import 'dart:io';

import 'package:pet_perfect_app/home/export.dart';
import 'package:pet_perfect_app/home/models/deworming.dart';
import 'package:pet_perfect_app/home/models/measurement.dart';
import 'package:pet_perfect_app/home/models/vaccination.dart';

class UserData {
  // static SharedPreferences preferences;
  // static const String KEY_SELECTED_THEME = 'key_selected_theme';
  static UserData user;
  PetRecordsAndNotes petRecordsAndNotes;
  TopicsData topicData;
  String parentFirstName;
  String parentLastName;
  String parentName;
  String accessToken;
  String message;
  int expires;
  String firstName;
  String lastName;
  int phoneNumber;
  String petId;
  String petFirstName;
  String petLastName;
  String refreshToken;
  String petType;
  String breed;
  String gender;
  File petImage;
  bool petRegistered;

  static init() {
    user = UserData();
  }

  // String getAccessToken() {
  //   print("tokii " + user.accessToken.toString());
  //   return user.accessToken;
  // }

  // void saveAuthenticationAndUserData(Registration userDetails) {
  //   print("Saving phoneNumber " + userDetails.phoneNumber.toString());
  //   user.parentFirstName = userDetails.firstName;
  //   user.parentLastName = userDetails.lastName;
  //   user.phoneNumber = userDetails.phoneNumber;
  //   user.accessToken = userDetails.accessToken;
  //   user.refreshToken = userDetails.refreshToken;
  //   user.expires = userDetails.expires;
  //   print(UserData.user.phoneNumber);
  // }

  // void saveAuthenticationAndUserAndPetData(
  //     Registration userDetails, String petId) {
  //   print("Saving phoneNumber " + userDetails.phoneNumber.toString());
  //   user.parentFirstName = userDetails.firstName;
  //   user.parentLastName = userDetails.lastName;
  //   user.phoneNumber = userDetails.phoneNumber;
  //   user.accessToken = userDetails.accessToken;
  //   user.refreshToken = userDetails.refreshToken;
  //   user.expires = userDetails.expires;
  //   user.petId = petId;
  //   print(UserData.user.phoneNumber);
  // }

  // void saveUserData(String firstName, String lastName, int phoneNumber) {
  //   user.firstName = firstName;
  //   user.lastName = lastName;
  //   user.phoneNumber = phoneNumber;
  // }

  // void savePetDetails(String petId) {
  //   user.petId = petId;
  // }

  void savePetRecordsAndNotes(PetRecordsAndNotes data) {
    user.petRecordsAndNotes = data;
    print("inside save function");
  }

  PetRecordsAndNotes getPetRecordsAndNotes() {
    if (user != null && user.petRecordsAndNotes != null)
      return user.petRecordsAndNotes;
    return null;
  }

  VaccinationForStatus getVaccination() {
    if (user != null && user.petRecordsAndNotes != null)
      return user.petRecordsAndNotes.vaccinations;
    return null;
  }

  List<Measurement> getMeasurement() {
    if (user != null && user.petRecordsAndNotes != null)
      return user.petRecordsAndNotes.measurements;
    return null;
  }

  DewormingForStatus getDeworming() {
    if (user != null && user.petRecordsAndNotes != null)
      return user.petRecordsAndNotes.dewormings;
    return null;
  }
  // void\\\ getMeasurement() {
  //   return user.petRecordsAndNotes.measurements;
  // }

//   static void saveTheme(AppTheme selectedTheme) {
//     if (null == selectedTheme) {
//       selectedTheme = AppTheme.lightTheme;
//     }
//     String theme = jsonEncode(selectedTheme.toString());
//     preferences.setString(KEY_SELECTED_THEME, theme);
//   }

//   static AppTheme getTheme() {
//     String theme = preferences.getString(KEY_SELECTED_THEME);
//     if (null == theme) {
//       return AppTheme.lightTheme;
//     }
//     return getThemeFromString(jsonDecode(theme));
//   }

//   static AppTheme getThemeFromString(String theme) {
//     for (AppTheme appTheme in AppTheme.values) {
//       if (appTheme.toString() == theme) {
//         return appTheme;
//       }
//     }
//     return AppTheme.lightTheme;
//   }
}
