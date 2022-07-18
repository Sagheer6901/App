import 'dart:convert';

import 'dart:async';
import 'package:http/http.dart' as http;
List<RatingsModel> ratingFromJson(String str) => List<RatingsModel>.from(json.decode(str).map((x) => RatingsModel.fromJson(x)));


class RatingsModel {
  RatingsModel({
    this.service,
    this.organization,
    this.friendliness,
    this.areaExpert,
    this.safety,
    this.hotelId,
    this.userId,

  });

  String? service;
  String? organization;
  String? friendliness;
  String? areaExpert;
  String? safety;
  String? hotelId;
  String? userId;

  factory RatingsModel.fromJson(Map<String, dynamic> json) => RatingsModel(
      service: json["service"],
      organization: json["organization"],
      friendliness: json['friendliness'],
      areaExpert: json["area_expert"],
      safety: json['safety'],
      hotelId: json['hotel_id'],
      userId: json['user_id']
  );

  Map<String, dynamic> toJson() => {
    "service": service,
    "organization": organization,
    "friendliness": friendliness,
    "area_expert": areaExpert,
    "safety": safety,
    "hotel_id":hotelId,
    "user_id":userId,
  };
}
