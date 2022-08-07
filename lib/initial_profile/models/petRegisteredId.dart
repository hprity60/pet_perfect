// To parse this JSON data, do
//
//     final petIdAndMessage = petIdAndMessageFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PetIdAndMessage petIdAndMessageFromJson(String str) =>
    PetIdAndMessage.fromJson(json.decode(str));

String petIdAndMessageToJson(PetIdAndMessage data) =>
    json.encode(data.toJson());

class PetIdAndMessage {
  PetIdAndMessage({
    @required this.message,
    @required this.petId,
  });

  final String message;
  final String petId;

  factory PetIdAndMessage.fromJson(Map<String, dynamic> json) =>
      PetIdAndMessage(
        message: json["message"] == null ? null : json["message"],
        petId: json["petId"] == null ? null : json["petId"],
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "petId": petId == null ? null : petId,
      };
}
