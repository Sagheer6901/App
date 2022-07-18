import 'dart:convert';

import 'dart:async';
import 'package:http/http.dart' as http;


class Plans {
  Plans({
    this.id,
    this.name,
    this.price,
    this.title,
    this.description,

  });

  String? id;
  String? name;
  String? price;
  String? title;
  String? description;

  factory Plans.fromJson(Map<String, dynamic> json) => Plans(
    id: json["id"],
    name: json["name"],
    price: json['price'],
    title: json["title"],
    description: json['description']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "title": title,
    "description": description
  };
}
