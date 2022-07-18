// To parse this JSON data, do
//
//     final hotelReview = hotelReviewFromJson(jsonString);

import 'dart:convert';

List<HotelReview> hotelReviewFromJson(String str) => List<HotelReview>.from(json.decode(str).map((x) => HotelReview.fromJson(x)));

String hotelReviewToJson(List<HotelReview> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HotelReview {
  HotelReview({
    this.id,
    this.hotelId,
    this.name,
    this.email,
    this.comment,
    this.date,
    this.status,
    this.image,
  });

  String? id;
  String? hotelId;
  String? name;
  String? email;
  String? comment;
  DateTime? date;
  String? status;
  String? image;

  factory HotelReview.fromJson(Map<String, dynamic> json) => HotelReview(
    id: json["id"],
    hotelId: json["hotel_id"],
    name: json["name"],
    email: json["email"],
    comment: json["comment"],
    date: DateTime.parse(json["date"]),
    status: json["status"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "hotel_id": hotelId,
    "name": name,
    "email": email,
    "comment": comment,
    "date": date!.toIso8601String(),
    "status": status,
    "image": image
  };
}
