import 'dart:convert';

import 'package:pet_perfect_app/logger.dart';

class Service {
  String name;
  String service;
  String category;
  List<String> images;
  String thumbnail;
  String address;
  double rating;
  int numRatings;
  String phoneNumber;
  double distance;
  double latitude;
  double longitude;
  int holiday;
  Map<String, List<String>> timings;

  Service(
      {this.name,
      this.service,
      this.category,
      this.images,
      this.thumbnail,
      this.address,
      this.rating,
      this.numRatings,
      this.phoneNumber,
      this.distance,
      this.latitude,
      this.longitude,
      this.timings,
      this.holiday});

  factory Service.fromJson(Map<String, dynamic> json) {
    convertTime(timings) {
      final times = ["0", "1", "2", "3", "4", "5", "6"];
      Map<String, List<String>> listOfTimings = {};

      for (var time in times) {
        listOfTimings[time] = List<String>.from(
            timings[time].map((x) => x)); // MAP IS BEING CALLED ON NULL
      }
      //List<String>.from(json["images"].map((x) => x))
      return listOfTimings;
    }

    getHoliday(timings) {
      //To Be Changed
      return 0;
    }

    removeEmptyStringFromDouble(reviewPoints) {
      if (reviewPoints == '' || reviewPoints == -1) return 0.0;
      double a = reviewPoints.toDouble();
      return a;
    }

    removeEmptyStringFromInt(reviewPoints) {
      if (reviewPoints == '') return 0;
      return reviewPoints;
    }

    return Service(
        name: json["title"],
        service: json["service"],
        category: json["category"],
        images: List<String>.from(json["images"].map((x) => x)),
        address: json["address"],
        rating: removeEmptyStringFromDouble(json["reviewPoints"]),
        numRatings: removeEmptyStringFromInt(json["reviews"]),
        phoneNumber: json["phone"],
        distance: json["dist"]["calculated"] / 1000,
        latitude: json["dist"]["location"]["coordinates"][1],
        longitude: json["dist"]["location"]["coordinates"][0],
        timings: convertTime(json[
            "openTime"]), //Map<String, List<String>>.from(json["openTime"]),
        // holiday: getHoliday(json["openTime"]),

        thumbnail: json["images"][0]);
  }
  String getDayForNumber(int num) {
    switch (num) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
    }
  }
}
