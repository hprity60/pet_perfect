class Measurement {
  double height;
  double weight;
  int age;
  DateTime timestamp;

  Measurement({this.height, this.weight, this.age, this.timestamp});
  factory Measurement.fromJson(Map<String, dynamic> json) => Measurement(
      height: json["height"],
      weight: json["weight"],
      age: json["age"],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json["timestamp"]));
}
