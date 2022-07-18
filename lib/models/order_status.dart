// To parse this JSON data, do
//
//     final orderStatus = orderStatusFromJson(jsonString);

import 'dart:convert';

List<OrderStatus> orderStatusFromJson(String str) => List<OrderStatus>.from(json.decode(str).map((x) => OrderStatus.fromJson(x)));

String orderStatusToJson(List<OrderStatus> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderStatus {
  OrderStatus({
    this.affectedRows,
    this.orderId,
    this.paymentStatus,
    this.message,
    this.amount,
    this.affect,
  });

  int? affectedRows;
  String? orderId;
  String? paymentStatus;
  String? message;
  String? amount;
  String? affect;

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
    affectedRows: json["affected_rows"],
    orderId: json["orderId"],
    paymentStatus: json["payment_status"],
    message: json["message"],
    amount: json["amount"],
    affect: json["affect"]
  );

  Map<String, dynamic> toJson() => {
    "affected_rows": affectedRows,
    "orderId": orderId,
    "payment_status": paymentStatus,
    "message": message,
    "amount": amount,
    "affect":affect
  };
}
