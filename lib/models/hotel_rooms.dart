// To parse this JSON data, do
//
//     final hotelRooms = hotelRoomsFromJson(jsonString);

import 'dart:convert';

List<HotelRooms> hotelRoomsFromJson(String str) => List<HotelRooms>.from(json.decode(str).map((x) => HotelRooms.fromJson(x)));

String hotelRoomsToJson(List<HotelRooms> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HotelRooms {
  HotelRooms({
    this.id,
    this.title,
    this.price,
    this.numRoom,
    this.bed,
    this.size,
    this.img1,
    this.img2,
    this.img3,
    this.imgcover,
    this.hotelId,
    this.adult,
    this.children,
    this.attribute,
    this.checkin,
    this.checkout,
  });

  String? id;
  String? title;
  String? price;
  String? numRoom;
  String? bed;
  String? size;
  String? img1;
  String? img2;
  String? img3;
  String? imgcover;
  String? hotelId;
  String? adult;
  String? children;
  String? attribute;
  String? checkin;
  String? checkout;

  factory HotelRooms.fromJson(Map<String, dynamic> json) => HotelRooms(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    numRoom: json["num_room"],
    bed: json["bed"],
    size: json["size"],
    img1: json["img1"],
    img2: json["img2"],
    img3: json["img3"],
    imgcover: json["imgcover"],
    hotelId: json["hotel_id"],
    adult: json["adult"],
    children: json["children"],
    attribute: json["attribute"],
    checkin: json["checkin"],
    checkout: json["checkout"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "num_room": numRoom,
    "bed": bed,
    "size": size,
    "img1": img1,
    "img2": img2,
    "img3": img3,
    "imgcover": imgcover,
    "hotel_id": hotelId,
    "adult": adult,
    "children": children,
    "attribute": attribute,
    "checkin": checkin,
    "checkout": checkout,
  };
}
