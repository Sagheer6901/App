import 'dart:convert';

List<TripListModel> tripListFromJson(String str) => List<TripListModel>.from(json.decode(str).map((x) => TripListModel.fromJson(x)));

String tripListToJson(List<TripListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TripListModel {
  TripListModel({
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
    this.location,
    this.duration,
    this.price,
    this.availability,
    this.terms,
    this.image,
    this.gallery,
    this.booked,
    this.vender,
  });

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
  String? location;
  String? duration;
  String? price;
  String? availability;
  String? terms;
  String? image;
  String? gallery;
  dynamic? booked;
  String? vender;

  factory TripListModel.fromJson(Map<String, dynamic> json) => TripListModel(
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
    location: json["location"],
    duration: json["duration"],
    price: json["price"],
    availability: json["availability"],
    terms: json["terms"],
    image: json["image"],
    gallery: json["gallery"],
    booked: json["booked"],
    vender: json["vender"],
  );

  Map<String, dynamic> toJson() => {
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
    "location": location,
    "duration": duration,
    "price": price,
    "availability": availability,
    "terms": terms,
    "image": image,
    "gallery": gallery,
    "booked": booked,
    "vender": vender,
  };
}
