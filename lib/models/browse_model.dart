// To parse this JSON data, do
//
//     final browse = browseFromJson(jsonString);

import 'dart:convert';

Browse browseFromJson(String str) => Browse.fromJson(json.decode(str));

String browseToJson(Browse data) => json.encode(data.toJson());

class Browse {
  Browse({
    this.lowest5,
    this.highest5,
    this.highest5Ewz,
    this.highest5CasesPer100K,
  });

  List<Highest5> lowest5;
  List<Highest5> highest5;
  List<Highest5> highest5Ewz;
  List<Highest5> highest5CasesPer100K;

  factory Browse.fromJson(Map<String, dynamic> json) => Browse(
        lowest5: List<Highest5>.from(
            json["lowest5"].map((x) => Highest5.fromJson(x))),
        highest5: List<Highest5>.from(
            json["highest5"].map((x) => Highest5.fromJson(x))),
        highest5Ewz: List<Highest5>.from(
            json["highest5EWZ"].map((x) => Highest5.fromJson(x))),
        highest5CasesPer100K: List<Highest5>.from(
            json["highest5casesPer100k"].map((x) => Highest5.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lowest5": List<dynamic>.from(lowest5.map((x) => x.toJson())),
        "highest5": List<dynamic>.from(highest5.map((x) => x.toJson())),
        "highest5EWZ": List<dynamic>.from(highest5Ewz.map((x) => x.toJson())),
        "highest5casesPer100k":
            List<dynamic>.from(highest5CasesPer100K.map((x) => x.toJson())),
      };
}

class Highest5 {
  Highest5({
    this.casesPer100K,
    this.rs,
    this.ewz,
    this.cases7Per100K,
    this.gen,
    this.bez,
    this.newCases,
  });

  double casesPer100K;
  String rs;
  int ewz;
  double cases7Per100K;
  String gen;
  String bez;
  int newCases;

  factory Highest5.fromJson(Map<String, dynamic> json) => Highest5(
        casesPer100K: json["cases_per_100k"].toDouble(),
        rs: json["RS"],
        ewz: json["EWZ"],
        cases7Per100K: json["cases7_per_100k"].toDouble(),
        gen: json["GEN"],
        bez: json["BEZ"],
        newCases: json["newCases"] == null ? null : json["newCases"],
      );

  Map<String, dynamic> toJson() => {
        "cases_per_100k": casesPer100K,
        "RS": rs,
        "EWZ": ewz,
        "cases7_per_100k": cases7Per100K,
        "GEN": gen,
        "BEZ": bez,
        "newCases": newCases == null ? null : newCases,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
