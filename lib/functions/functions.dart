import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(
  IconData icons,
  String hinttext,
) {
  return InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    errorStyle: const TextStyle(color: Colors.white),
    fillColor: Colors.white,
    filled: true,
    hintText: hinttext,
    prefixIcon: Icon(icons, color: Colors.black),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(color: Colors.black, width: 1.5),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(
        color: Colors.white,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(
        color: Colors.white,
      ),
    ),
  );
}
