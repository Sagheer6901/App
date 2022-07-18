// To parse this JSON data, do
//
//     final carWishList = carWishListFromJson(jsonString);

import 'dart:convert';

List<HotelModel> carWishListFromJson(String str) => List<HotelModel>.from(json.decode(str).map((x) => HotelModel.fromJson(x)));

String carWishListToJson(List<HotelModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HotelModel {
  HotelModel({
    this.wishlistId,
    this.hotelId,
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
    this.rank,
    this.gallery,
    this.location,
    this.vendor,
    this.booked,
    this.status,
  });

  String? wishlistId;
  String? hotelId;
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
  String? price;
  String? availability;
  String? terms;
  String? image;
  String? rank;
  String? gallery;
  String? location;
  String? vendor;
  String? booked;
  String? status;

  factory HotelModel.fromJson(Map<String, dynamic> json) => HotelModel(
    wishlistId: json["wishlist_id"],
    hotelId: json["hotel_id"],
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
    rank: json["rank"],
    gallery: json["gallery"],
    location: json["location"],
    vendor: json["vendor"],
    booked: json["booked"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "wishlist_id": wishlistId,
    "hotel_id": hotelId,
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
    "rank": rank,
    "gallery": gallery,
    "location": location,
    "vendor": vendor,
    "booked": booked,
    "status": status,
  };
}
