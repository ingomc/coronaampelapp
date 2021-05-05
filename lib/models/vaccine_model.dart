// To parse this JSON data, do
//
//     final vaccine = vaccineFromJson(jsonString);
// @dart=2.9
import 'dart:convert';

Vaccine vaccineFromJson(String str) => Vaccine.fromJson(json.decode(str));

String vaccineToJson(Vaccine data) => json.encode(data.toJson());

class Vaccine {
  Vaccine({
    this.states,
    this.lastUpdate,
    this.germany,
  });

  List<State> states;
  String lastUpdate;
  Germany germany;

  factory Vaccine.fromJson(Map<String, dynamic> json) => Vaccine(
        states: List<State>.from(json["states"].map((x) => State.fromJson(x))),
        lastUpdate: json["last_update"],
        germany: Germany.fromJson(json["germany"]),
      );

  Map<String, dynamic> toJson() => {
        "states": List<dynamic>.from(states.map((x) => x.toJson())),
        "last_update": lastUpdate,
        "germany": germany.toJson(),
      };
}

class Germany {
  Germany({
    this.total,
    this.sumVaccineDoses,
    this.differenceToThePreviousDay,
    this.cumsum7DaysAgo,
  });

  int total;
  int sumVaccineDoses;
  int differenceToThePreviousDay;
  int cumsum7DaysAgo;

  factory Germany.fromJson(Map<String, dynamic> json) => Germany(
        total: json["total"] == null ? 0 : json["total"],
        sumVaccineDoses:
            json["sum_vaccine_doses"] == null ? 0 : json["sum_vaccine_doses"],
        differenceToThePreviousDay:
            json["difference_to_the_previous_day"] == null
                ? 0
                : json["difference_to_the_previous_day"],
        cumsum7DaysAgo:
            json["cumsum_7_days_ago"] == null ? 0 : json["cumsum_7_days_ago"],
      );

  Map<String, dynamic> toJson() => {
        "total": total == null ? 0 : total,
        "sum_vaccine_doses": sumVaccineDoses == null ? 0 : sumVaccineDoses,
        "difference_to_the_previous_day":
            differenceToThePreviousDay == null ? 0 : differenceToThePreviousDay,
        "cumsum_7_days_ago": cumsum7DaysAgo == null ? 0 : cumsum7DaysAgo,
      };
}

class State {
  State({
    this.name,
    this.total,
    this.rs,
    this.vaccinated,
    this.differenceToThePreviousDay,
  });

  String name;
  int total;
  String rs;
  int vaccinated;
  int differenceToThePreviousDay;

  factory State.fromJson(Map<String, dynamic> json) => State(
        name: json["name"],
        total: json["total"] == null ? 0 : json["total"],
        rs: json["rs"],
        vaccinated: json["vaccinated"] == null ? 0 : json["vaccinated"],
        differenceToThePreviousDay:
            json["difference_to_the_previous_day"] == null
                ? 0
                : json["difference_to_the_previous_day"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "total": total == null ? 0 : total,
        "rs": rs,
        "vaccinated": vaccinated == null ? 0 : vaccinated,
        "difference_to_the_previous_day":
            differenceToThePreviousDay == null ? 0 : differenceToThePreviousDay,
      };
}
