// ignore_for_file: file_names, unnecessary_this, prefer_const_constructors, unused_element, duplicate_ignore

import 'package:flutter/material.dart';

class CustomTextField {
  final String title;
  final String placeholder;
  final bool ispass;
  String err;
  String value;

  CustomTextField(
      {this.title = "",
      this.placeholder = "",
      this.ispass = false,
      this.err = "veuillez compléter?",
      this.value = ""});

  TextFormField textformfield() {
    return TextFormField(
      onChanged: (e) {
        value = e;
      },
      validator: (e) => e!.isEmpty ? this.err : null,
      obscureText: this.ispass,
      decoration: InputDecoration(
          hintText: this.placeholder,
          labelText: this.title,

          // ignore: prefer_const_constructors
          labelStyle: TextStyle(color: Colors.blueAccent),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(2))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent))),
    );
  }

  String get _value {
    return value;
  }
}
