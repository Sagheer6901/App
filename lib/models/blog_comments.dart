// {"id":"104","blog_id":"74","name":"Subhan Khan","email":"ahmedsubhan741@gmail.com","comment":"Nice","date":"2022-02-25
// 11:28:31","status":"seen"}

import 'dart:convert';

import 'dart:async';
import 'package:http/http.dart' as http;

class BlogsComments {
  BlogsComments({
    this.id,
    this.blogId,
    this.name,
    this.email,
    this.comment,
    this.date,
    this.status,
    this.image,
  });

  String? id;
  String? blogId;
  String? name;
  String? email;
  String? comment;
  DateTime? date;
  String? status;
  String? image;

  factory BlogsComments.fromJson(Map<String, dynamic> json) => BlogsComments(
      id: json["id"],
      blogId: json["blog_id"],
      name: json['name'],
      email: json["email"],
      comment: json['comment'],
      date: DateTime.parse(json["date"]),
      status: json['status'],
    image: json['image'],

  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "blog_id": blogId,
        "name": name,
        "email": email,
        "comment": comment,
        "date": date!.toIso8601String(),
        "status": status,
        "image": image,
      };
}
