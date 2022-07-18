// To parse this JSON data, do
//
//     final conversationModel = conversationModelFromJson(jsonString);

import 'dart:convert';

List<ConversationModel> conversationModelFromJson(String str) => List<ConversationModel>.from(json.decode(str).map((x) => ConversationModel.fromJson(x)));

String conversationModelToJson(List<ConversationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConversationModel {
  ConversationModel({
    this.chatId,
    this.receiverId,
    this.senderId,
    this.admin,
    this.driver,
    this.user,
    this.msg,
    this.attachment,
    this.dateSent,
    this.status,
    this.seen,
  });

  String? chatId;
  String? receiverId;
  String? senderId;
  String? admin;
  dynamic driver;
  String? user;
  String? msg;
  String? attachment;
  String? dateSent;
  String? status;
  String? seen;

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
    chatId: json["chat_id"],
    receiverId: json["receiver_id"],
    senderId: json["sender_id"],
    admin: json["admin"],
    driver: json["driver"],
    user: json["user"],
    msg: json["msg"],
    attachment: json["attachment"],
    dateSent: json["date_sent"],
    status: json["status"],
    seen: json["seen"],
  );

  Map<String, dynamic> toJson() => {
    "chat_id": chatId,
    "receiver_id": receiverId,
    "sender_id": senderId,
    "admin": admin,
    "driver": driver,
    "user": user,
    "msg": msg,
    "attachment": attachment,
    "date_sent": dateSent,
    "status": status,
    "seen": seen,
  };
}
