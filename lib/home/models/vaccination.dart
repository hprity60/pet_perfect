class Vaccination {
  String name;
  String description;
  DateTime date;
  int age;
  String status;
  bool req;

  Vaccination(
      {this.name,
      this.description,
      this.date,
      this.age,
      this.status,
      this.req});
  factory Vaccination.fromJson(Map<String, dynamic> json) => Vaccination(
        name: json["vaccination"],
        description: json["description"],
        date: DateTime.fromMillisecondsSinceEpoch(json["deadLine"]),
        age: json["age"],
        status: json["status"],
        req: json["bRequired"],
      );
}

class VaccinationForStatus {
  List<String> statuses = ["completed", "pending", "upcoming"];
  List<Vaccination> completedVaccination;
  List<Vaccination> pendingVaccination;
  List<Vaccination> upcomingVaccination;
  VaccinationForStatus(
      {this.completedVaccination,
      this.pendingVaccination,
      this.upcomingVaccination});
  factory VaccinationForStatus.fromJson(Map<String, dynamic> json) {
    print("Hellloooo, I'm thereee");
    return VaccinationForStatus(
      completedVaccination: List<Vaccination>.from(
          json["completed"].map((x) => Vaccination.fromJson(x))),
      pendingVaccination: List<Vaccination>.from(
          json["pending"].map((x) => Vaccination.fromJson(x))),
      upcomingVaccination: List<Vaccination>.from(
          json["upcoming"].map((x) => Vaccination.fromJson(x))),
    );
  }
}
