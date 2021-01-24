// To parse this JSON data, do
//
//     final worldwide = worldwideFromJson(jsonString);

import 'dart:convert';

Worldwide worldwideFromJson(String str) => Worldwide.fromJson(json.decode(str));

String worldwideToJson(Worldwide data) => json.encode(data.toJson());

class Worldwide {
  Worldwide({
    this.global,
    this.germany,
  });

  Global global;
  Germany germany;

  factory Worldwide.fromJson(Map<String, dynamic> json) => Worldwide(
        global: Global.fromJson(json["global"]),
        germany: Germany.fromJson(json["germany"]),
      );

  Map<String, dynamic> toJson() => {
        "global": global.toJson(),
        "germany": germany.toJson(),
      };
}

class Germany {
  Germany({
    this.lastUpdate,
    this.ewz,
    this.cases,
    this.cases7Per100K,
    this.objectId,
    this.newCases,
    this.newDeaths,
  });

  String lastUpdate;
  int ewz;
  int cases;
  double cases7Per100K;
  int objectId;
  int newCases;
  int newDeaths;

  factory Germany.fromJson(Map<String, dynamic> json) => Germany(
        lastUpdate: json["last_update"],
        ewz: json["EWZ"],
        cases: json["cases"],
        cases7Per100K: json["cases7_per_100k"].toDouble(),
        objectId: json["ObjectId"],
        newCases: json["newCases"],
        newDeaths: json["newDeaths"],
      );

  Map<String, dynamic> toJson() => {
        "last_update": lastUpdate,
        "EWZ": ewz,
        "cases": cases,
        "cases7_per_100k": cases7Per100K,
        "ObjectId": objectId,
        "newCases": newCases,
        "newDeaths": newDeaths,
      };
}

class Global {
  Global({
    this.updated,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.todayRecovered,
    this.active,
    this.critical,
    this.casesPerOneMillion,
    this.deathsPerOneMillion,
    this.tests,
    this.testsPerOneMillion,
    this.population,
    this.oneCasePerPeople,
    this.oneDeathPerPeople,
    this.oneTestPerPeople,
    this.activePerOneMillion,
    this.recoveredPerOneMillion,
    this.criticalPerOneMillion,
    this.affectedCountries,
    this.lastUpdate,
  });

  int updated;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int todayRecovered;
  int active;
  int critical;
  double casesPerOneMillion;
  double deathsPerOneMillion;
  int tests;
  double testsPerOneMillion;
  int population;
  double oneCasePerPeople;
  double oneDeathPerPeople;
  double oneTestPerPeople;
  double activePerOneMillion;
  double recoveredPerOneMillion;
  double criticalPerOneMillion;
  int affectedCountries;
  String lastUpdate;

  factory Global.fromJson(Map<String, dynamic> json) => Global(
        updated: json["updated"],
        cases: json["cases"],
        todayCases: json["todayCases"],
        deaths: json["deaths"],
        todayDeaths: json["todayDeaths"],
        recovered: json["recovered"],
        todayRecovered: json["todayRecovered"],
        active: json["active"],
        critical: json["critical"],
        casesPerOneMillion: json["casesPerOneMillion"].toDouble(),
        deathsPerOneMillion: json["deathsPerOneMillion"].toDouble(),
        tests: json["tests"],
        testsPerOneMillion: json["testsPerOneMillion"].toDouble(),
        population: json["population"],
        oneCasePerPeople: json["oneCasePerPeople"].toDouble(),
        oneDeathPerPeople: json["oneDeathPerPeople"].toDouble(),
        oneTestPerPeople: json["oneTestPerPeople"].toDouble(),
        activePerOneMillion: json["activePerOneMillion"].toDouble(),
        recoveredPerOneMillion: json["recoveredPerOneMillion"].toDouble(),
        criticalPerOneMillion: json["criticalPerOneMillion"].toDouble(),
        affectedCountries: json["affectedCountries"],
        lastUpdate: json["last_update"],
      );

  Map<String, dynamic> toJson() => {
        "updated": updated,
        "cases": cases,
        "todayCases": todayCases,
        "deaths": deaths,
        "todayDeaths": todayDeaths,
        "recovered": recovered,
        "todayRecovered": todayRecovered,
        "active": active,
        "critical": critical,
        "casesPerOneMillion": casesPerOneMillion,
        "deathsPerOneMillion": deathsPerOneMillion,
        "tests": tests,
        "testsPerOneMillion": testsPerOneMillion,
        "population": population,
        "oneCasePerPeople": oneCasePerPeople,
        "oneDeathPerPeople": oneDeathPerPeople,
        "oneTestPerPeople": oneTestPerPeople,
        "activePerOneMillion": activePerOneMillion,
        "recoveredPerOneMillion": recoveredPerOneMillion,
        "criticalPerOneMillion": criticalPerOneMillion,
        "affectedCountries": affectedCountries,
        "last_update": lastUpdate,
      };
}
