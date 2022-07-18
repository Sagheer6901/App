import 'dart:convert';

List<FilterTerms> filterTermsFromJson(String str) => List<FilterTerms>.from(json.decode(str).map((x) => FilterTerms.fromJson(x)));

String filterTermsToJson(List<FilterTerms> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FilterTerms {
  FilterTerms({
    this.termName,
  });

  String? termName;

  factory FilterTerms.fromJson(Map<String, dynamic> json) => FilterTerms(
    termName: json["term_name"],
  );

  Map<String, dynamic> toJson() => {
    "term_name": termName,
  };
}