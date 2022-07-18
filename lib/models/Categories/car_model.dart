// To parse this JSON data, do
//
//     final carWishList = carWishListFromJson(jsonString);

import 'dart:convert';

List<CarModel> carWishListFromJson(String str) => List<CarModel>.from(json.decode(str).map((x) => CarModel.fromJson(x)));

String carWishListToJson(List<CarModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CarModel {
  CarModel({
    this.wishlistId,
    this.carId,
    this.userId,
    this.id,
    this.title,
    this.description,
    this.videoLink,
    this.rating,
    this.policyTitle,
    this.policyContent,
    this.passenger,
    this.gear,
    this.baggage,
    this.door,
    this.address,
    this.brand,
    this.price,
    this.carNumber,
    this.model,
    this.featured,
    this.state,
    this.location,
    this.terms,
    this.image,
    this.gallery,
    this.booked,
    this.vender,
  });

  String? wishlistId;
  String? carId;
  String? userId;
  String? id;
  String? title;
  String? description;
  String? videoLink;
  String? rating;
  String? policyTitle;
  String? policyContent;
  String? passenger;
  String? gear;
  String? baggage;
  String? door;
  String? address;
  String? brand;
  String? price;
  String? carNumber;
  String? model;
  String? featured;
  String? state;
  String? location;
  String? terms;
  String? image;
  String? gallery;
  String? booked;
  String? vender;

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
    wishlistId: json['wishlist_id'],
    carId: json["car_id"],
    userId: json["user_id"],
    id: json["id"],
    title: json["title"],
    description: json["description"],
    videoLink: json["video_link"],
    rating: json['rating'],
    policyTitle: json["policy_title"],
    policyContent: json["policy_content"],
    passenger: json["passenger"],
    gear: json["gear"],
    baggage: json["baggage"],
    door: json["door"],
    address: json["address"],
    brand: json["brand"],
    price: json["price"],
    carNumber: json["car_number"],
    model: json["model"],
    featured: json["featured"],
    state: json["state"],
    location: json["location"],
    terms: json["terms"],
    image: json["image"],
    gallery: json["gallery"],
    booked: json["booked"],
    vender: json["vender"],
  );

  Map<String, dynamic> toJson() => {
    "wishlist_id": wishlistId,
    "car_id": carId,
    "user_id": userId,
    "id": id,
    "title": title,
    "description": description,
    "video_link": videoLink,
    "rating":rating,
    "policy_title": policyTitle,
    "policy_content": policyContent,
    "passenger": passenger,
    "gear": gear,
    "baggage": baggage,
    "door": door,
    "address": address,
    "brand": brand,
    "price": price,
    "car_number": carNumber,
    "model": model,
    "featured": featured,
    "state": state,
    "location": location,
    "terms": terms,
    "image": image,
    "gallery": gallery,
    "booked": booked,
    "vender": vender,
  };
}
