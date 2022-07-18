// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

List<Notification> notificationFromJson(String str) => List<Notification>.from(json.decode(str).map((x) => Notification.fromJson(x)));

String notificationToJson(List<Notification> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notification {
  Notification({
    this.notiCount,
  });

  String? notiCount;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    notiCount: json["noti_count"],
  );

  Map<String, dynamic> toJson() => {
    "noti_count": notiCount,
  };
}
