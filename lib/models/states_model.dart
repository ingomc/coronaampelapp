// To parse this JSON data, do
//
//     final states = statesFromJson(jsonString);
// @dart=2.9
import 'dart:convert';

States statesFromJson(String str) => States.fromJson(json.decode(str));

String statesToJson(States data) => json.encode(data.toJson());

class States {
  States({
    this.locations,
    this.lastUpdate,
  });

  List<State> locations;
  String lastUpdate;

  factory States.fromJson(Map<String, dynamic> json) => States(
        locations:
            List<State>.from(json["locations"].map((x) => State.fromJson(x))),
        lastUpdate: json["last_update"],
      );

  Map<String, dynamic> toJson() => {
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
        "last_update": lastUpdate,
      };
}

class State {
  State({
    this.objectid,
    this.lanEwAgs,
    this.lanEwGen,
    this.lanEwBez,
    this.lanEwEwz,
    this.fallzahl,
    this.death,
    this.cases7BlPer100K,
    this.cases7Bl,
    this.death7Bl,
    this.objectid1,
    this.lastUpdate,
    this.newCases,
    this.newDeaths,
  });

  int objectid;
  String lanEwAgs;
  String lanEwGen;
  String lanEwBez;
  int lanEwEwz;
  int fallzahl;
  int death;
  double cases7BlPer100K;
  int cases7Bl;
  int death7Bl;
  int objectid1;
  String lastUpdate;
  int newCases;
  int newDeaths;

  factory State.fromJson(Map<String, dynamic> json) => State(
        objectid: json["OBJECTID"],
        lanEwAgs: json["LAN_ew_AGS"],
        lanEwGen: json["LAN_ew_GEN"],
        lanEwBez: json["LAN_ew_BEZ"],
        lanEwEwz: json["LAN_ew_EWZ"] == null ? 0 : json["LAN_ew_EWZ"],
        fallzahl: json["Fallzahl"] == null ? 0 : json["Fallzahl"],
        death: json["Death"] == null ? 0 : json["Death"],
        cases7BlPer100K: json["cases7_bl_per_100k"] == null
            ? 0.0
            : json["cases7_bl_per_100k"].toDouble(),
        cases7Bl: json["cases7_bl"] == null ? 0 : json["cases7_bl"],
        death7Bl: json["death7_bl"] == null ? 0 : json["death7_bl"],
        objectid1: json["OBJECTID_1"],
        lastUpdate: json["last_update"],
        newCases: json["new_cases"] == null ? 0 : json["new_cases"],
        newDeaths: json["new_deaths"] == null ? 0 : json["new_deaths"],
      );

  Map<String, dynamic> toJson() => {
        "OBJECTID": objectid,
        "LAN_ew_AGS": lanEwAgs,
        "LAN_ew_GEN": lanEwGen,
        "LAN_ew_BEZ": lanEwBez,
        "LAN_ew_EWZ": lanEwEwz == null ? 0 : lanEwEwz,
        "Fallzahl": fallzahl == null ? 0 : fallzahl,
        "Death": death == null ? 0 : death,
        "cases7_bl_per_100k": cases7BlPer100K == null ? 0.0 : cases7BlPer100K,
        "cases7_bl": cases7Bl == null ? 0 : cases7Bl,
        "death7_bl": death7Bl == null ? 0 : death7Bl,
        "OBJECTID_1": objectid1,
        "last_update": lastUpdate,
        "new_cases": newCases == null ? 0 : newCases,
        "new_deaths": newDeaths == null ? 0 : newDeaths,
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
