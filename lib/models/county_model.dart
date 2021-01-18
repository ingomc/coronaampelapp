// To parse this JSON data, do
//
//     final county = countyFromJson(jsonString);

import 'dart:convert';

County countyFromJson(String str) => County.fromJson(json.decode(str));

String countyToJson(County data) => json.encode(data.toJson());

class County {
  County({
    this.data,
  });

  List<Data> data;

  factory County.fromJson(Map<String, dynamic> json) => County(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    this.bettenFrei,
    this.bettenBelegt,
    this.bettenGesamt,
    this.anteilBettenFrei,
    this.faelleCovidAktuell,
    this.faelleCovidAktuellBeatmet,
    this.anteilCovidBeatmet,
    this.anteilCovidBetten,
    this.datenStand,
    this.objectid,
    this.ade,
    this.gf,
    this.bsg,
    this.rs,
    this.ags,
    this.sdvRs,
    this.gen,
    this.bez,
    this.ibz,
    this.bem,
    this.nbd,
    this.snL,
    this.snR,
    this.snK,
    this.snV1,
    this.snV2,
    this.snG,
    this.fkS3,
    this.nuts,
    this.rs0,
    this.ags0,
    this.wsk,
    this.ewz,
    this.kfl,
    this.debkgId,
    this.shapeArea,
    this.shapeLength,
    this.deathRate,
    this.cases,
    this.deaths,
    this.casesPer100K,
    this.casesPerPopulation,
    this.bl,
    this.blId,
    this.county,
    this.lastUpdate,
    this.cases7Per100K,
    this.recovered,
    this.ewzBl,
    this.cases7BlPer100K,
    this.cases7Bl,
    this.death7Bl,
    this.cases7Lk,
    this.death7Lk,
    this.cases7Per100KTxt,
  });

  int bettenFrei;
  int bettenBelegt;
  int bettenGesamt;
  double anteilBettenFrei;
  int faelleCovidAktuell;
  int faelleCovidAktuellBeatmet;
  int anteilCovidBeatmet;
  double anteilCovidBetten;
  String datenStand;
  int objectid;
  int ade;
  int gf;
  int bsg;
  String rs;
  String ags;
  String sdvRs;
  String gen;
  String bez;
  int ibz;
  String bem;
  String nbd;
  String snL;
  String snR;
  String snK;
  String snV1;
  String snV2;
  String snG;
  String fkS3;
  String nuts;
  String rs0;
  String ags0;
  String wsk;
  int ewz;
  double kfl;
  String debkgId;
  double shapeArea;
  double shapeLength;
  double deathRate;
  int cases;
  int deaths;
  double casesPer100K;
  double casesPerPopulation;
  String bl;
  String blId;
  String county;
  String lastUpdate;
  double cases7Per100K;
  dynamic recovered;
  int ewzBl;
  double cases7BlPer100K;
  int cases7Bl;
  int death7Bl;
  int cases7Lk;
  int death7Lk;
  String cases7Per100KTxt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bettenFrei: json["betten_frei"],
        bettenBelegt: json["betten_belegt"],
        bettenGesamt: json["betten_gesamt"],
        anteilBettenFrei: json["Anteil_betten_frei"] != null
            ? json["Anteil_betten_frei"].toDouble()
            : 0,
        faelleCovidAktuell: json["faelle_covid_aktuell"],
        faelleCovidAktuellBeatmet: json["faelle_covid_aktuell_beatmet"],
        anteilCovidBeatmet: json["Anteil_covid_beatmet"],
        anteilCovidBetten: json["Anteil_COVID_betten"] != null
            ? json["Anteil_COVID_betten"].toDouble()
            : 0,
        datenStand: json["daten_stand"],
        objectid: json["OBJECTID"],
        ade: json["ADE"],
        gf: json["GF"],
        bsg: json["BSG"],
        rs: json["RS"],
        ags: json["AGS"],
        sdvRs: json["SDV_RS"],
        gen: json["GEN"],
        bez: json["BEZ"],
        ibz: json["IBZ"],
        bem: json["BEM"],
        nbd: json["NBD"],
        snL: json["SN_L"],
        snR: json["SN_R"],
        snK: json["SN_K"],
        snV1: json["SN_V1"],
        snV2: json["SN_V2"],
        snG: json["SN_G"],
        fkS3: json["FK_S3"],
        nuts: json["NUTS"],
        rs0: json["RS_0"],
        ags0: json["AGS_0"],
        wsk: json["WSK"],
        ewz: json["EWZ"],
        kfl: json["KFL"] != null ? json["KFL"].toDouble() : 0,
        debkgId: json["DEBKG_ID"],
        shapeArea: 0,
        shapeLength: 0,
        deathRate:
            json["death_rate"] != null ? json["death_rate"].toDouble() : 0,
        cases: json["cases"],
        deaths: json["deaths"],
        casesPer100K: json["cases_per_100k"] != null
            ? json["cases_per_100k"].toDouble()
            : 0,
        casesPerPopulation: json["cases_per_population"] != null
            ? json["cases_per_population"].toDouble()
            : 0,
        bl: json["BL"],
        blId: json["BL_ID"],
        county: json["county"],
        lastUpdate: json["last_update"],
        cases7Per100K: json["cases7_per_100k"] != null
            ? json["cases7_per_100k"].toDouble()
            : 0,
        recovered: json["recovered"],
        ewzBl: json["EWZ_BL"],
        cases7BlPer100K: json["cases7_bl_per_100k"] != null
            ? json["cases7_bl_per_100k"].toDouble()
            : 0,
        cases7Bl: json["cases7_bl"],
        death7Bl: json["death7_bl"],
        cases7Lk: json["cases7_lk"],
        death7Lk: json["death7_lk"],
        cases7Per100KTxt: json["cases7_per_100k_txt"],
      );

  Map<String, dynamic> toJson() => {
        "betten_frei": bettenFrei,
        "betten_belegt": bettenBelegt,
        "betten_gesamt": bettenGesamt,
        "Anteil_betten_frei": anteilBettenFrei,
        "faelle_covid_aktuell": faelleCovidAktuell,
        "faelle_covid_aktuell_beatmet": faelleCovidAktuellBeatmet,
        "Anteil_covid_beatmet": anteilCovidBeatmet,
        "Anteil_COVID_betten": anteilCovidBetten,
        "daten_stand": datenStand,
        "OBJECTID": objectid,
        "ADE": ade,
        "GF": gf,
        "BSG": bsg,
        "RS": rs,
        "AGS": ags,
        "SDV_RS": sdvRs,
        "GEN": gen,
        "BEZ": bez,
        "IBZ": ibz,
        "BEM": bem,
        "NBD": nbd,
        "SN_L": snL,
        "SN_R": snR,
        "SN_K": snK,
        "SN_V1": snV1,
        "SN_V2": snV2,
        "SN_G": snG,
        "FK_S3": fkS3,
        "NUTS": nuts,
        "RS_0": rs0,
        "AGS_0": ags0,
        "WSK": wsk,
        "EWZ": ewz,
        "KFL": kfl,
        "DEBKG_ID": debkgId,
        "Shape__Area": shapeArea,
        "Shape__Length": shapeLength,
        "death_rate": deathRate,
        "cases": cases,
        "deaths": deaths,
        "cases_per_100k": casesPer100K,
        "cases_per_population": casesPerPopulation,
        "BL": bl,
        "BL_ID": blId,
        "county": county,
        "last_update": lastUpdate,
        "cases7_per_100k": cases7Per100K,
        "recovered": recovered,
        "EWZ_BL": ewzBl,
        "cases7_bl_per_100k": cases7BlPer100K,
        "cases7_bl": cases7Bl,
        "death7_bl": death7Bl,
        "cases7_lk": cases7Lk,
        "death7_lk": death7Lk,
        "cases7_per_100k_txt": cases7Per100KTxt,
      };
}
