// To parse this JSON data, do
//
//     final orderId = orderIdFromJson(jsonString);

import 'dart:convert';

List<OrderId> orderIdFromJson(String str) => List<OrderId>.from(json.decode(str).map((x) => OrderId.fromJson(x)));

String orderIdToJson(List<OrderId> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderId {
  OrderId({
    this.lastid,
    this.response,
  });

  int? lastid;
  String? response;

  factory OrderId.fromJson(Map<String, dynamic> json) => OrderId(
    lastid: json["lastid"],
    response: json["response"],
  );

  Map<String, dynamic> toJson() => {
    "lastid": lastid,
    "response": response,
  };
}
