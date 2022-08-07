// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    @required this.message,
  });

  final String message;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
      };
}
