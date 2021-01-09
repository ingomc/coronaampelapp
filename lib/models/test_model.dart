// To parse this JSON data, do
//
//     final citys = citysFromJson(jsonString);

import 'dart:convert';

Citys citysFromJson(String str) => Citys.fromJson(json.decode(str));

String citysToJson(Citys data) => json.encode(data.toJson());

class Citys {
  Citys({
    this.objectIdFieldName,
    this.uniqueIdField,
    this.globalIdFieldName,
    this.geometryType,
    this.spatialReference,
    this.fields,
    this.features,
  });

  String objectIdFieldName;
  UniqueIdField uniqueIdField;
  String globalIdFieldName;
  String geometryType;
  SpatialReference spatialReference;
  List<Field> fields;
  List<Feature> features;

  factory Citys.fromJson(Map<String, dynamic> json) => Citys(
        objectIdFieldName: json["objectIdFieldName"],
        uniqueIdField: UniqueIdField.fromJson(json["uniqueIdField"]),
        globalIdFieldName: json["globalIdFieldName"],
        geometryType: json["geometryType"],
        spatialReference: SpatialReference.fromJson(json["spatialReference"]),
        fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "objectIdFieldName": objectIdFieldName,
        "uniqueIdField": uniqueIdField.toJson(),
        "globalIdFieldName": globalIdFieldName,
        "geometryType": geometryType,
        "spatialReference": spatialReference.toJson(),
        "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
      };
}

class Feature {
  Feature({
    this.attributes,
  });

  Attributes attributes;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "attributes": attributes.toJson(),
      };
}

class Attributes {
  Attributes({
    this.cases7Per100K,
    this.ags,
    this.bez,
    this.bl,
    this.cases,
    this.cases7BlPer100K,
    this.cases7Lk,
    this.county,
    this.deaths,
    this.deathRate,
    this.ewz,
    this.gen,
    this.lastUpdate,
    this.objectid,
    this.rs,
  });

  double cases7Per100K;
  String ags;
  String bez;
  String bl;
  int cases;
  double cases7BlPer100K;
  int cases7Lk;
  String county;
  int deaths;
  double deathRate;
  int ewz;
  String gen;
  String lastUpdate;
  int objectid;
  String rs;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        cases7Per100K: json["cases7_per_100k"].toDouble(),
        ags: json["AGS"],
        bez: json["BEZ"],
        bl: json["BL"],
        cases: json["cases"],
        cases7BlPer100K: json["cases7_bl_per_100k"].toDouble(),
        cases7Lk: json["cases7_lk"],
        county: json["county"],
        deaths: json["deaths"],
        deathRate: json["death_rate"].toDouble(),
        ewz: json["EWZ"],
        gen: json["GEN"],
        lastUpdate: json["last_update"],
        objectid: json["OBJECTID"],
        rs: json["RS"],
      );

  Map<String, dynamic> toJson() => {
        "cases7_per_100k": cases7Per100K,
        "AGS": ags,
        "BEZ": bez,
        "BL": bl,
        "cases": cases,
        "cases7_bl_per_100k": cases7BlPer100K,
        "cases7_lk": cases7Lk,
        "county": county,
        "deaths": deaths,
        "death_rate": deathRate,
        "EWZ": ewz,
        "GEN": gen,
        "last_update": lastUpdate,
        "OBJECTID": objectid,
        "RS": rs,
      };
}

class Field {
  Field({
    this.name,
    this.type,
    this.alias,
    this.sqlType,
    this.domain,
    this.defaultValue,
    this.length,
  });

  String name;
  String type;
  String alias;
  SqlType sqlType;
  dynamic domain;
  dynamic defaultValue;
  int length;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        name: json["name"],
        type: json["type"],
        alias: json["alias"],
        sqlType: sqlTypeValues.map[json["sqlType"]],
        domain: json["domain"],
        defaultValue: json["defaultValue"],
        length: json["length"] == null ? null : json["length"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "alias": alias,
        "sqlType": sqlTypeValues.reverse[sqlType],
        "domain": domain,
        "defaultValue": defaultValue,
        "length": length == null ? null : length,
      };
}

enum SqlType { SQL_TYPE_OTHER }

final sqlTypeValues = EnumValues({"sqlTypeOther": SqlType.SQL_TYPE_OTHER});

class SpatialReference {
  SpatialReference({
    this.wkid,
    this.latestWkid,
  });

  int wkid;
  int latestWkid;

  factory SpatialReference.fromJson(Map<String, dynamic> json) =>
      SpatialReference(
        wkid: json["wkid"],
        latestWkid: json["latestWkid"],
      );

  Map<String, dynamic> toJson() => {
        "wkid": wkid,
        "latestWkid": latestWkid,
      };
}

class UniqueIdField {
  UniqueIdField({
    this.name,
    this.isSystemMaintained,
  });

  String name;
  bool isSystemMaintained;

  factory UniqueIdField.fromJson(Map<String, dynamic> json) => UniqueIdField(
        name: json["name"],
        isSystemMaintained: json["isSystemMaintained"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "isSystemMaintained": isSystemMaintained,
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
