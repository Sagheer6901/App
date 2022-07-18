import 'dart:async';
import 'dart:convert' show json;
import 'package:http/http.dart' as http;

class LoginDB {
  final String? userEmail;
  final String? userPass;

  LoginDB({
    this.userEmail,
    this.userPass,
  });

}
