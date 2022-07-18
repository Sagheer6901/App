import 'dart:convert';

import 'dart:async';
import 'package:http/http.dart' as http;


class Blogs {
  Blogs({
    this.id,
    this.title,
    this.description,
    this.cat,
    this.image,
    this.yt,
    this.date,
  });

  String? id;
  String? title;
  String? description;
  String? cat;
  String? image;
  String? yt;
  DateTime? date;

  factory Blogs.fromJson(Map<String, dynamic> json) => Blogs(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        cat: json["cat"],
        image: json["image"],
        yt: json["yt"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "cat": cat,
        "image": image,
        "yt": yt,
        "date": date!.toIso8601String(),
      };
}
