// To parse this JSON data, do
//
//     final countys = countysFromJson(jsonString);
// @dart=2.9
import 'dart:convert';

Countys countysFromJson(String str) => Countys.fromJson(json.decode(str));

String countysToJson(Countys data) => json.encode(data.toJson());

class Countys {
  Countys({
    this.locations,
    this.date,
  });

  List<Location> locations;
  String date;

  factory Countys.fromJson(Map<String, dynamic> json) => Countys(
        locations: List<Location>.from(
            json["locations"].map((x) => Location.fromJson(x))),
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
        "date": date,
      };
}

class Location {
  Location({
    this.rs,
    this.cases7Per100K,
    this.gen,
    this.bez,
    this.newCases,
  });

  String rs;
  double cases7Per100K;
  String gen;
  String bez;
  int newCases;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        rs: json["RS"],
        cases7Per100K: json["cases7_per_100k"].toDouble(),
        gen: json["GEN"],
        bez: json["BEZ"],
        newCases: json["newCases"] == null || json["newCases"] < 1
            ? 0
            : json["newCases"],
      );

  Map<String, dynamic> toJson() => {
        "RS": rs,
        "cases7_per_100k": cases7Per100K,
        "GEN": gen,
        "BEZ": bez,
        "newCases": newCases > 0 ? newCases : null,
      };
}
