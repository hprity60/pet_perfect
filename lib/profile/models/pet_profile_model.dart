import 'package:pet_perfect_app/home/models/measurement.dart';
import 'package:pet_perfect_app/home/models/picture.dart';

import 'documents.dart';

class PetProfileModel {
  String name;
  String type;
  String breed;
  String birthday;
  String gender;
  Picture image;
  String height;
  String weight;
  String bloodGroup;
  List<Picture> images;
  String registrationId;
  String appearance;
  String likings;
  String dislikings;
  String bodyMarks;
  String friendliness;
  String enregyLevel;
  String favoured;
  Measurement measurement;
  String medicalHistory;
  String hereditary;
  String allergies;
  String training;
  DocumentsModel documents;
  PetProfileModel(
      {this.name,
      this.type,
      this.breed,
      this.birthday,
      this.gender,
      this.image,
      this.height,
      this.weight,
      this.bloodGroup,
      this.images,
      this.registrationId,
      this.appearance,
      this.likings,
      this.dislikings,
      this.bodyMarks,
      this.friendliness,
      this.enregyLevel,
      this.favoured,
      this.measurement,
      this.medicalHistory,
      this.hereditary,
      this.training,
      this.allergies,
      this.documents});
  factory PetProfileModel.fromJson(Map<String, dynamic> json) =>
      PetProfileModel(
        name: json["name"],
        images:
            List<Picture>.from(json["images"].map((x) => Picture.fromJson(x))),
        type: json["type"],
        breed: json["breed"],
        birthday: json["birthday"],
        gender: json["gender"],
        image: Picture.fromJson(json["distance"]),
        weight: json["weight"],
        bloodGroup: json["bloodGroup"],
        registrationId: json["registrationId"],
        appearance: json["appearance"],
        likings: json["likings"],
        dislikings: json["dislikings"],
        bodyMarks: json["bodyMarks"],
        friendliness: json["friendliness"],
        enregyLevel: json["enregyLevel"],
        favoured: json["favoured"],
        measurement: Measurement.fromJson(json["distance"]),
        medicalHistory: json["medicalHistory"],
        hereditary: json["hereditary"],
        training: json["training"],
        allergies: json["allergies"],
        documents: DocumentsModel.fromJson(json["documents"]),
        height: json["height"],
      );
}
