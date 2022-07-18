// To parse this JSON data, do
//
//     final ticketConvModel = ticketConvModelFromJson(jsonString);

import 'dart:convert';

List<TicketConvModel> ticketConvModelFromJson(String str) => List<TicketConvModel>.from(json.decode(str).map((x) => TicketConvModel.fromJson(x)));

String ticketConvModelToJson(List<TicketConvModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TicketConvModel {
  TicketConvModel({
    this.id,
    this.ticketId,
    this.message,
    this.sender,
    this.reciever,
    this.sentAt,
    this.status,
  });

  String? id;
  String? ticketId;
  String? message;
  String? sender;
  String? reciever;
  String? sentAt;
  String? status;

  factory TicketConvModel.fromJson(Map<String, dynamic> json) => TicketConvModel(
    id: json["id"],
    ticketId: json["ticket_id"],
    message: json["message"],
    sender: json["sender"],
    reciever: json["reciever"],
    sentAt: json["sent_at"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ticket_id": ticketId,
    "message": message,
    "sender": sender,
    "reciever": reciever,
    "sent_at": sentAt,
    "status": status,
  };
}
