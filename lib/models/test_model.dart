// To parse this JSON data, do
//
//     final citysData = citysDataFromJson(jsonString);

import 'dart:convert';

List<CitysData> citysDataFromJson(String str) =>
    List<CitysData>.from(json.decode(str).map((x) => CitysData.fromJson(x)));

String citysDataToJson(List<CitysData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CitysData {
  CitysData({
    this.attributes,
  });

  Attributes attributes;

  factory CitysData.fromJson(Map<String, dynamic> json) => CitysData(
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "attributes": attributes.toJson(),
      };
}

class Attributes {
  Attributes({
    this.death7Bl,
    this.cases7BlPer100K,
  });

  int death7Bl;
  double cases7BlPer100K;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        death7Bl: json["death7_bl"],
        cases7BlPer100K: json["cases7_bl_per_100k"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "death7_bl": death7Bl,
        "cases7_bl_per_100k": cases7BlPer100K,
      };
}
