import 'dart:convert';

import 'package:pet_perfect_app/home/models/picture.dart';
import 'package:pet_perfect_app/home/models/vaccination.dart';

import 'deworming.dart';
import 'measurement.dart';

PetRecordsAndNotes welcomeFromJson(String str) =>
    PetRecordsAndNotes.fromJson(json.decode(str));

// String welcomeToJson(PetRecordsAndNotes data) => json.encode(data.toJson());

class PetRecordsAndNotes {
  PetRecordsAndNotes({
    this.pictures,
    this.vaccinations,
    this.dewormings,
    this.measurements,
    this.notes,
    this.message,
  });
  String message;
  List<Picture> pictures;
  VaccinationForStatus vaccinations;
  DewormingForStatus dewormings;
  List<Measurement> measurements;
  String notes;

  factory PetRecordsAndNotes.fromJson(Map<String, dynamic> json) {
    return PetRecordsAndNotes(
      // message: json["message"],
      notes: json["note"],
      vaccinations: VaccinationForStatus.fromJson(json["vaccination"]),
      pictures:
          List<Picture>.from(json["image"].map((x) => Picture.fromJson(x))),
      dewormings: DewormingForStatus.fromJson(json["deworming"]),
      measurements: List<Measurement>.from(
          json["measurement"].map((x) => Measurement.fromJson(x))),
    );
  }

  // Map<String, dynamic> toJson() => {
  //       "status": status,
  //       "totalResults": totalResults,
  //       "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
  //     };
}
