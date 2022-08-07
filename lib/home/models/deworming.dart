class Deworming {
  DateTime date;
  int age;
  String status;

  Deworming({this.date, this.age, this.status});
  factory Deworming.fromJson(Map<String, dynamic> json) => Deworming(
        date: DateTime.fromMillisecondsSinceEpoch(json["deadLine"]),
        age: json["age"],
        status: json["status"],
      );
}

class DewormingForStatus {
  List<String> statuses = ["completed", "pending", "upcoming"];
  List<Deworming> completedDeworming;
  List<Deworming> pendingDeworming;
  List<Deworming> upcomingDeworming;
  DewormingForStatus(
      {this.completedDeworming, this.pendingDeworming, this.upcomingDeworming});
  factory DewormingForStatus.fromJson(Map<String, dynamic> json) =>
      DewormingForStatus(
        completedDeworming: List<Deworming>.from(
            json["completed"].map((x) => Deworming.fromJson(x))),
        pendingDeworming: List<Deworming>.from(
            json["pending"].map((x) => Deworming.fromJson(x))),
        upcomingDeworming: List<Deworming>.from(
            json["upcoming"].map((x) => Deworming.fromJson(x))),
      );
}
