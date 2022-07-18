// To parse this JSON data, do
//
//     final popularCitiesModel = popularCitiesModelFromJson(jsonString);

import 'dart:convert';

List<PopularCitiesModel> popularCitiesModelFromJson(String str) => List<PopularCitiesModel>.from(json.decode(str).map((x) => PopularCitiesModel.fromJson(x)));

String popularCitiesModelToJson(List<PopularCitiesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PopularCitiesModel {
  PopularCitiesModel({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.date,
    this.gmap,
  });

  String? id;
  String? name;
  String? slug;
  String? description;
  DateTime? date;
  String? gmap;

  factory PopularCitiesModel.fromJson(Map<String, dynamic> json) => PopularCitiesModel(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    description: json["description"],
    date: DateTime.parse(json["date"]),
    gmap: json["gmap"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "description": description,
    "date": date!.toIso8601String(),
    "gmap": gmap,
  };
}
