// To parse this JSON data, do
//
//     final bloodGroups = bloodGroupsFromJson(jsonString);

import 'dart:convert';

BloodGroups bloodGroupsFromJson(String str) =>
    BloodGroups.fromJson(json.decode(str));

String bloodGroupsToJson(BloodGroups data) => json.encode(data.toJson());

class BloodGroups {
  BloodGroups({
    this.petType,
    this.bloodGroupsArray,
  });

  String petType;
  List<String> bloodGroupsArray;

  factory BloodGroups.fromJson(Map<String, dynamic> json) => BloodGroups(
        petType: json["petType"],
        bloodGroupsArray:
            List<String>.from(json["bloodGroupsArray"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "petType": petType,
        "bloodGroupsArray": List<dynamic>.from(bloodGroupsArray.map((x) => x)),
      };
}
