import 'package:pet_perfect_app/home/models/picture.dart';

class DocumentsModel {
  List<Picture> medicalPrescriptions;
  List<Picture> registrationDocuments;
  List<Picture> certifications;
  DocumentsModel(
      {this.medicalPrescriptions,
      this.registrationDocuments,
      this.certifications});
  factory DocumentsModel.fromJson(Map<String, dynamic> json) => DocumentsModel(
        medicalPrescriptions: List<Picture>.from(
            json["pictures"].map((x) => Picture.fromJson(x))),
        registrationDocuments: List<Picture>.from(
            json["registrationDocuments"].map((x) => Picture.fromJson(x))),
        certifications: List<Picture>.from(
          json["certifications"].map((x) => Picture.fromJson(x)),
        ),
      );
}
