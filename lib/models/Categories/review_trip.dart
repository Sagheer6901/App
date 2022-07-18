
import 'dart:convert';

List<TripReviews> tripReviewsFromJson(String str) => List<TripReviews>.from(json.decode(str).map((x) => TripReviews.fromJson(x)));

String tripReviewsToJson(List<TripReviews> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TripReviews {
  TripReviews({
    this.id,
    this.activityId,
    this.name,
    this.email,
    this.comment,
    this.date,
    this.status,
    this.image,
  });

  String? id;
  String? activityId;
  String? name;
  String? email;
  String? comment;
  DateTime? date;
  String? status;
  dynamic? image;

  factory TripReviews.fromJson(Map<String, dynamic> json) => TripReviews(
    id: json["id"],
    activityId: json["activity_id"],
    name: json["name"],
    email: json["email"],
    comment: json["comment"],
    date: DateTime.parse(json["date"]),
    status: json["status"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "activity_id": activityId,
    "name": name,
    "email": email,
    "comment": comment,
    "date": date!.toIso8601String(),
    "status": status,
    "image": image,
  };
}
