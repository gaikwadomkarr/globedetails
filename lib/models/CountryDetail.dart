// To parse this JSON data, do
//
//     final countryDetail = countryDetailFromJson(jsonString);

import 'dart:convert';

List<CountryDetail> countryDetailFromJson(String str) =>
    List<CountryDetail>.from(
        json.decode(str).map((x) => CountryDetail.fromJson(x)));

String countryDetailToJson(List<CountryDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryDetail {
  CountryDetail({
    this.name,
    this.alpha2Code,
    this.alpha3Code,
    this.callingCodes,
    this.capital,
    this.currencies,
    this.flag,
    this.population,
    this.demonym,
  });

  String name;
  String alpha2Code;
  String alpha3Code;
  List<String> callingCodes;
  String capital;
  List<Currency> currencies;
  String flag;
  int population;
  String demonym;

  factory CountryDetail.fromJson(Map<String, dynamic> json) => CountryDetail(
        name: json["name"] == null ? null : json["name"],
        alpha2Code: json["alpha2Code"] == null ? null : json["alpha2Code"],
        alpha3Code: json["alpha3Code"] == null ? null : json["alpha3Code"],
        callingCodes: json["callingCodes"] == null
            ? null
            : List<String>.from(json["callingCodes"].map((x) => x)),
        capital: json["capital"] == null ? null : json["capital"],
        currencies: json["currencies"] == null
            ? null
            : List<Currency>.from(
                json["currencies"].map((x) => Currency.fromJson(x))),
        flag: json["flag"] == null ? null : json["flag"],
        population: json["population"] == null ? null : json["population"],
        demonym: json["demonym"] == null ? null : json["demonym"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "alpha2Code": alpha2Code == null ? null : alpha2Code,
        "alpha3Code": alpha3Code == null ? null : alpha3Code,
        "callingCodes": callingCodes == null
            ? null
            : List<dynamic>.from(callingCodes.map((x) => x)),
        "capital": capital == null ? null : capital,
        "currencies": currencies == null
            ? null
            : List<dynamic>.from(currencies.map((x) => x.toJson())),
        "flag": flag == null ? null : flag,
        "population": population == null ? null : population,
        "demonym": demonym == null ? null : demonym,
      };
}

class Currency {
  Currency({
    this.code,
    this.name,
    this.symbol,
  });

  String code;
  String name;
  String symbol;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        code: json["code"] == null ? null : json["code"],
        name: json["name"] == null ? null : json["name"],
        symbol: json["symbol"] == null ? null : json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "name": name == null ? null : name,
        "symbol": symbol == null ? null : symbol,
      };
}
