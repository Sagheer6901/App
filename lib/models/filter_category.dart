// To parse this JSON data, do
//
//     final filterCategories = filterCategoriesFromJson(jsonString);

import 'dart:convert';

List<FilterCategories> filterCategoriesFromJson(String str) => List<FilterCategories>.from(json.decode(str).map((x) => FilterCategories.fromJson(x)));

String filterCategoriesToJson(List<FilterCategories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FilterCategories {
  FilterCategories({
    this.name,
  });

  String? name;

  factory FilterCategories.fromJson(Map<String, dynamic> json) => FilterCategories(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
