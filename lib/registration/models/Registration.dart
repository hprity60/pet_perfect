// To parse this JSON data, do
//
//     final registration = registrationFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Registration registrationFromJson(String str) =>
    Registration.fromJson(json.decode(str));

String registrationToJson(Registration data) => json.encode(data.toJson());

class Registration {
  Registration({
    @required this.accessToken,
    @required this.message,
    @required this.expires,
    @required this.firstName,
    @required this.lastName,
    @required this.phoneNumber,
    @required this.refreshToken,
  });

  final String accessToken;
  final String message;
  final int expires;
  String firstName;
  String lastName;
  int phoneNumber;
  final String refreshToken;

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
        accessToken: json["accessToken"] == null ? null : json["accessToken"],
        message: json["message"] == null ? null : json["message"],
        expires: json["expires"] == null ? null : json["expires"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        refreshToken:
            json["refreshToken"] == null ? null : json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken == null ? null : accessToken,
        "message": message == null ? null : message,
        "expires": expires == null ? null : expires,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "refreshToken": refreshToken == null ? null : refreshToken,
      };

  populateDetails(int phoneNumber, String firstName, String lastName) {
    this.phoneNumber = phoneNumber;
    this.firstName = firstName;
    this.lastName = lastName;
  }
}
