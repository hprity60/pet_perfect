// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

User fromVars(String firstName, String lastName, int phoneNumber) =>
    User.fromVars(firstName, lastName, phoneNumber);

toRegistrationJson(User user) => user.toRegistrationJson();

class User {
  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.accessToken,
  });

  String userId;
  String firstName;
  String lastName;
  int phoneNumber;
  String accessToken;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        accessToken: json["accessToken"],
      );

  factory User.fromVars(String firstName, String lastName, int phoneNumber) =>
      User(
        userId: null,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        accessToken: null,
      );

  Map<String, dynamic> toRegistrationJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber.toString(),
      };

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber.toString(),
        "accessToken": accessToken,
      };
}
