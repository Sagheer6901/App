import 'dart:convert';
List<BlogCategory> blogCategoryFromJson(String str) => List<BlogCategory>.from(json.decode(str).map((x) => BlogCategory.fromJson(x)));

String blogCategoryToJson(List<BlogCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlogCategory {
  BlogCategory({
    this.id,
    this.title,
  });

  String? id;
  String? title;

  factory BlogCategory.fromJson(Map<String, dynamic> json) => BlogCategory(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
