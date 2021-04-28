// To parse this JSON data, do
//
//     final countries = countriesFromJson(jsonString);

import 'dart:convert';

List<Countries> countriesFromJson(String str) =>
    List<Countries>.from(json.decode(str).map((x) => Countries.fromJson(x)));

String countriesToJson(List<Countries> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Countries {
  Countries({
    this.name,
    this.flag,
  });

  String name;
  String flag;

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
        name: json["name"] == null ? null : json["name"],
        flag: json["flag"] == null ? null : json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "flag": flag == null ? null : flag,
      };
}
