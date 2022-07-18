import 'dart:async';
import 'dart:convert' show json;
import 'package:http/http.dart' as http;

class RegisterDB {
  final String? userFirstName;
  final String? userLastName;
  final String? userEmail;
  final String? userContact;
  final String? userPass;

  RegisterDB({
    this.userFirstName,
    this.userLastName,
    this.userEmail,
    this.userContact,
    this.userPass,
  });

  factory RegisterDB.fromJson(Map<String, dynamic> json) => RegisterDB(
        userFirstName: json["user_first_name"],
        userLastName: json["user_last_name"],
        userEmail: json["user_email"],
        userContact: json['user_contact'],
        userPass: json['user_pass'],
      );

  Map<String, dynamic> toJson() => {
        "user_first_name": userFirstName,
        "user_last_name": userLastName,
        "user_email": userEmail,
        "user_pass": userPass,
        "user_contact": userContact,
      };
}
