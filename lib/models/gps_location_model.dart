// To parse this JSON data, do
//
//     final gpsLocation = gpsLocationFromJson(jsonString);

import 'dart:convert';

GpsLocation gpsLocationFromJson(String str) =>
    GpsLocation.fromJson(json.decode(str));

String gpsLocationToJson(GpsLocation data) => json.encode(data.toJson());

class GpsLocation {
  GpsLocation({
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

  factory GpsLocation.fromJson(Map<String, dynamic> json) => GpsLocation(
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
    this.gen,
  });

  String gen;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        gen: json["GEN"],
      );

  Map<String, dynamic> toJson() => {
        "GEN": gen,
      };
}

class Field {
  Field({
    this.name,
    this.type,
    this.alias,
    this.sqlType,
    this.length,
    this.domain,
    this.defaultValue,
  });

  String name;
  String type;
  String alias;
  String sqlType;
  int length;
  dynamic domain;
  dynamic defaultValue;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        name: json["name"],
        type: json["type"],
        alias: json["alias"],
        sqlType: json["sqlType"],
        length: json["length"],
        domain: json["domain"],
        defaultValue: json["defaultValue"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "alias": alias,
        "sqlType": sqlType,
        "length": length,
        "domain": domain,
        "defaultValue": defaultValue,
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
