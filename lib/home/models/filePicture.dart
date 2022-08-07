import 'dart:io';

class FilePicture {
  File image;
  String date;
  FilePicture({this.image, this.date});

  factory FilePicture.fromJson(Map<String, dynamic> json) => FilePicture(
        image: json["url"],
        date: json["date"],
  );
}
