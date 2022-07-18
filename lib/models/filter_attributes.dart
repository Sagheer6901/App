
import 'dart:convert';

List<FilterAttributes> filterAttributesFromJson(String str) => List<FilterAttributes>.from(json.decode(str).map((x) => FilterAttributes.fromJson(x)));

String filterAttributesToJson(List<FilterAttributes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FilterAttributes {
  FilterAttributes({
    this.id,
    this.attributeName,
  });

  String? id;
  String? attributeName;

  factory FilterAttributes.fromJson(Map<String, dynamic> json) => FilterAttributes(
    id: json["id"],
    attributeName: json["attribute_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attribute_name": attributeName,
  };
}