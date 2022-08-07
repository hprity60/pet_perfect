// To parse this JSON data, do
//
//     final auth = authFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Authentication authFromJson(String str) =>
    Authentication.fromJson(json.decode(str));

String authToJson(Authentication data) => json.encode(data.toJson());

class Authentication {
  Authentication({
    @required this.message,
    @required this.sessionId,
    this.code,
  });

  final String message;
  final String sessionId;
  final String code;

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
        message: json["message"] == null ? null : json["message"],
        sessionId: json["sessionId"] == null ? null : json["sessionId"],
        code:json["code"],
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "sessionId": sessionId == null ? null : sessionId,
      };
}
