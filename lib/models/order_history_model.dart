// To parse this JSON data, do
//
//     final orderHistory = orderHistoryFromJson(jsonString);

import 'dart:convert';

List<OrderHistory> orderHistoryFromJson(String str) => List<OrderHistory>.from(json.decode(str).map((x) => OrderHistory.fromJson(x)));

String orderHistoryToJson(List<OrderHistory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderHistory {
  OrderHistory({
    this.id,
    this.tripId,
    this.userId,
    this.fullname,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.stateProvince,
    this.zipCode,
    this.country,
    this.price,
    this.specialRequest,
    this.cardHolderName,
    this.cardNumber,
    this.expiryMonth,
    this.expiryYear,
    this.cvv,
    this.status,
    this.paymentStatus,
    this.paymentMsg,
    this.paymentMethod,
    this.date,
    this.title,
    this.description,
    this.videoLink,
    this.rating,
    this.policyTitle,
    this.policyContent,
    this.checkin,
    this.checkout,
    this.location,
    this.duration,
    this.availability,
    this.terms,
    this.image,
    this.gallery,
    this.booked,
    this.vender,
  });

  String? id;
  String? tripId;
  String? userId;
  String? fullname;
  String? email;
  String? phone;
  String? address;
  String? city;
  dynamic? stateProvince;
  dynamic? zipCode;
  String? country;
  String? price;
  dynamic? specialRequest;
  dynamic? cardHolderName;
  dynamic? cardNumber;
  dynamic? expiryMonth;
  dynamic? expiryYear;
  dynamic? cvv;
  String? status;
  String? paymentStatus;
  String? paymentMsg;
  dynamic? paymentMethod;
  DateTime? date;
  String? title;
  String? description;
  String? videoLink;
  String? rating;
  String? policyTitle;
  String? policyContent;
  String? checkin;
  String? checkout;
  String? location;
  String? duration;
  String? availability;
  String? terms;
  String? image;
  String? gallery;
  dynamic? booked;
  String? vender;

  factory OrderHistory.fromJson(Map<String, dynamic> json) => OrderHistory(
    id: json["id"],
    tripId: json["trip_id"],
    userId: json["user_id"],
    fullname: json["fullname"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    city: json["city"],
    stateProvince: json["state_province"],
    zipCode: json["zip_code"],
    country: json["country"],
    price: json["price"],
    specialRequest: json["Special_request"],
    cardHolderName: json["card_holder_name"],
    cardNumber: json["card_number"],
    expiryMonth: json["expiry_month"],
    expiryYear: json["expiry_year"],
    cvv: json["cvv"],
    status: json["status"],
    paymentStatus: json["payment_status"],
    paymentMsg: json["payment_msg"],
    paymentMethod: json["payment_method"],
    date: DateTime.parse(json["date"]),
    title: json["title"],
    description: json["description"],
    videoLink: json["video_link"],
    rating: json["rating"],
    policyTitle: json["policy_title"],
    policyContent: json["policy_content"],
    checkin: json["checkin"],
    checkout: json["checkout"],
    location: json["location"],
    duration: json["duration"],
    availability: json["availability"],
    terms: json["terms"],
    image: json["image"],
    gallery: json["gallery"],
    booked: json["booked"],
    vender: json["vender"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trip_id": tripId,
    "user_id": userId,
    "fullname": fullname,
    "email": email,
    "phone": phone,
    "address": address,
    "city": city,
    "state_province": stateProvince,
    "zip_code": zipCode,
    "country": country,
    "price": price,
    "Special_request": specialRequest,
    "card_holder_name": cardHolderName,
    "card_number": cardNumber,
    "expiry_month": expiryMonth,
    "expiry_year": expiryYear,
    "cvv": cvv,
    "status": status,
    "payment_status": paymentStatus,
    "payment_msg": paymentMsg,
    "payment_method": paymentMethod,
    "date": date!.toIso8601String(),
    "title": title,
    "description": description,
    "video_link": videoLink,
    "rating": rating,
    "policy_title": policyTitle,
    "policy_content": policyContent,
    "checkin": checkin,
    "checkout": checkout,
    "location": location,
    "duration": duration,
    "availability": availability,
    "terms": terms,
    "image": image,
    "gallery": gallery,
    "booked": booked,
    "vender": vender,
  };
}
