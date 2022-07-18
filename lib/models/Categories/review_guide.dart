// To parse this JSON data, do
//
//     final guideReview = guideReviewFromJson(jsonString);

import 'dart:convert';

List<GuideReview> guideReviewFromJson(String str) => List<GuideReview>.from(json.decode(str).map((x) => GuideReview.fromJson(x)));

String guideReviewToJson(List<GuideReview> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GuideReview {
  GuideReview({
    this.id,
    this.guideId,
    this.name,
    this.email,
    this.comment,
    this.date,
    this.status,
    this.image,
  });

  String? id;
  String? guideId;
  String? name;
  String? email;
  String? comment;
  DateTime? date;
  String? status;
  String? image;

  factory GuideReview.fromJson(Map<String, dynamic> json) => GuideReview(
    id: json["id"],
    guideId: json["guide_id"],
    name: json["name"],
    email: json["email"],
    comment: json["comment"],
    date: DateTime.parse(json["date"]),
    status: json["status"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "guide_id": guideId,
    "name": name,
    "email": email,
    "comment": comment,
    "date": date!.toIso8601String(),
    "status": status,
    "image": image,
  };
}
