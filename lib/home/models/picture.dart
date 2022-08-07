import 'dart:io';

class Picture {
  String url;
  String thumbnail;
  DateTime date;
  int age;
  File file;
  Picture({this.url, this.thumbnail, this.date, this.age, this.file});

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        url: json["url"],
        date: DateTime.fromMillisecondsSinceEpoch(json["timestamp"]),
        age: json["age"],
        thumbnail: json["thumbnail"],
        file: json["file"],
      );
}
