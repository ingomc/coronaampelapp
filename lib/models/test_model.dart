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
    this.objectid,
    this.gen,
    this.bez,
    this.rs,
    this.cases7Per100K,
    this.lastUpdate,
  });

  int objectid;
  String gen;
  String bez;
  String rs;
  double cases7Per100K;
  String lastUpdate;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        objectid: json["OBJECTID"],
        gen: json["GEN"],
        bez: json["BEZ"],
        rs: json["RS"],
        cases7Per100K: json["cases7_per_100k"].toDouble(),
        lastUpdate: json["last_update"],
      );

  Map<String, dynamic> toJson() => {
        "OBJECTID": objectid,
        "GEN": gen,
        "BEZ": bez,
        "RS": rs,
        "cases7_per_100k": cases7Per100K,
        "last_update": lastUpdate,
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
  String sqlType;
  dynamic domain;
  dynamic defaultValue;
  int length;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        name: json["name"],
        type: json["type"],
        alias: json["alias"],
        sqlType: json["sqlType"],
        domain: json["domain"],
        defaultValue: json["defaultValue"],
        length: json["length"] == null ? null : json["length"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "alias": alias,
        "sqlType": sqlType,
        "domain": domain,
        "defaultValue": defaultValue,
        "length": length == null ? null : length,
      };
}

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
