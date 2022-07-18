// To parse this JSON data, do
//
//     final carReview = carReviewFromJson(jsonString);

import 'dart:convert';

List<CarReview> carReviewFromJson(String str) => List<CarReview>.from(json.decode(str).map((x) => CarReview.fromJson(x)));

String carReviewToJson(List<CarReview> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CarReview {
  CarReview({
    this.id,
    this.carId,
    this.name,
    this.email,
    this.comment,
    this.date,
    this.status,
    this.image,
  });

  String? id;
  String? carId;
  String? name;
  String? email;
  String? comment;
  DateTime? date;
  String? status;
  String? image;

  factory CarReview.fromJson(Map<String, dynamic> json) => CarReview(
    id: json["id"],
    carId: json["car_id"],
    name: json["name"],
    email: json["email"],
    comment: json["comment"],
    date: DateTime.parse(json["date"]),
    status: json["status"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "car_id": carId,
    "name": name,
    "email": email,
    "comment": comment,
    "date": date!.toIso8601String(),
    "status": status,
    "image": image
  };
}
