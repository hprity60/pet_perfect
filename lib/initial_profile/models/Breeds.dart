// To parse this JSON data, do
//
//     final breeds = breedsFromJson(jsonString);

import 'dart:convert';

Breeds breedsFromJson(String str) => Breeds.fromJson(json.decode(str));

String breedsToJson(Breeds data) => json.encode(data.toJson());

class Breeds {
  Breeds({
    this.petType,
    this.breedsArray,
  });

  String petType;
  List<String> breedsArray;

  factory Breeds.fromJson(Map<String, dynamic> json) => Breeds(
        petType: json["petType"],
        breedsArray: List<String>.from(json["breedsArray"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "petType": petType,
        "breedsArray": List<dynamic>.from(breedsArray.map((x) => x)),
      };
}
