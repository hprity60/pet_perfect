import 'dart:convert';

import 'package:pet_perfect_app/services/models/service.dart';

Services servicesFromJson(String str) => Services.fromJson(json.decode(str));

// String servicesFromJson(Services data) => json.encode(data.toJson());

class Services {
  Services({
    this.vets,
    this.groomers,
    this.boarders,
    this.trainers,
  });

  List<Service> vets;
  List<Service> groomers;
  List<Service> boarders;
  List<Service> trainers;

  factory Services.fromJson(Map<String, dynamic> json) => Services(
        vets: List<Service>.from(json["vets"].map((x) => Service.fromJson(x))),
        groomers: List<Service>.from(
            json["groomers"].map((x) => Service.fromJson(x))),
        boarders: List<Service>.from(
            json["boarders"].map((x) => Service.fromJson(x))),
        trainers: List<Service>.from(
            json["trainers"].map((x) => Service.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //       "status": status,
  //       "totalResults": totalResults,
  //       "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
  //     };
}
