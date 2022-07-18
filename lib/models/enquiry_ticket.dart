// To parse this JSON data, do
//
//     final ticketModel = ticketModelFromJson(jsonString);

import 'dart:convert';

List<TicketModel> ticketModelFromJson(String str) => List<TicketModel>.from(json.decode(str).map((x) => TicketModel.fromJson(x)));

String ticketModelToJson(List<TicketModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TicketModel {
  TicketModel({
    this.id,
    this.name,
    this.email,
    this.issue,
    this.file,
    this.ticket,
    this.status,
    this.date,
  });

  String? id;
  String? name;
  String? email;
  String? issue;
  String? file;
  String? ticket;
  String? status;
  DateTime?  date;

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    issue: json["issue"],
    file: json["file"],
    ticket: json["ticket"],
    status: json["status"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "issue": issue,
    "file": file,
    "ticket": ticket,
    "status": status,
    "date": date!.toIso8601String(),
  };
}
