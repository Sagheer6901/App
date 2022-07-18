// To parse this JSON data, do
//
//     final carWishList = carWishListFromJson(jsonString);

import 'dart:convert';

List<TourGuideModel> carWishListFromJson(String str) => List<TourGuideModel>.from(json.decode(str).map((x) => TourGuideModel.fromJson(x)));

String carWishListToJson(List<TourGuideModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TourGuideModel {
  TourGuideModel({
    this.wishlistId,
    this.guideId,
    this.userId,
    this.id,
    this.title,
    this.description,
    this.videoLink,
    this.rating,
    this.policyTitle,
    this.policyContent,
    this.address,
    this.checkin,
    this.checkout,
    this.price,
    this.availability,
    this.terms,
    this.image,
    this.gallery,
    this.booked,
    this.vender,
    this.location,
  });

  String? wishlistId;
  String? guideId;
  String? userId;
  String? id;
  String? title;
  String? description;
  String? videoLink;
  String? rating;
  String? policyTitle;
  String? policyContent;
  String? address;
  String? checkin;
  String? checkout;
  String ?price;
  String? availability;
  String? terms;
  String? image;
  String? gallery;
  String? booked;
  String? vender;
  String? location;

  factory TourGuideModel.fromJson(Map<String, dynamic> json) => TourGuideModel(
    wishlistId: json["wishlist_id"],
    guideId: json["guide_id"],
    userId: json["user_id"],
    id: json["id"],
    title: json["title"],
    description: json["description"],
    videoLink: json["video_link"],
    rating: json["rating"],
    policyTitle: json["policy_title"],
    policyContent: json["policy_content"],
    address: json["address"],
    checkin: json["checkin"],
    checkout: json["checkout"],
    price: json["price"],
    availability: json["availability"],
    terms: json["terms"],
    image: json["image"],
    gallery: json["gallery"],
    booked: json["booked"],
    vender: json["vender"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "wishlist_id": wishlistId,
    "guide_id": guideId,
    "user_id": userId,
    "id": id,
    "title": title,
    "description": description,
    "video_link": videoLink,
    "rating": rating,
    "policy_title": policyTitle,
    "policy_content": policyContent,
    "address": address,
    "checkin": checkin,
    "checkout": checkout,
    "price": price,
    "availability": availability,
    "terms": terms,
    "image": image,
    "gallery": gallery,
    "booked": booked,
    "vender": vender,
    "location": location,
  };
}
