// ignore_for_file: unnecessary_new, prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use, avoid_print, use_key_in_widget_constructors, duplicate_ignore, use_full_hex_values_for_flutter_colors, import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp6login/screen/authenfication/login.dart';
import 'package:myapp6login/widgets/costumerTexteField.dart';
import 'package:http/http.dart' as https;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  void register(String nomText, String emailText, String passWord) async {
    final response = await https.post(
      "https://projetmody.000webhostapp.com/article/register.php",
      headers: {"Accept": "application/json"},
      body: {
        "name": nomText,
        "email": emailText,
        "pass": passWord,
      },
      encoding: Encoding.getByName("utf-8"),
    );
    if (response.statusCode == 200) {
      print("OK");
    } else {
      print('Échec !');
    }
  }

  CustomTextField nomText =
      new CustomTextField(title: "Nom", placeholder: "entrer le nom");
  CustomTextField emailText =
      new CustomTextField(title: "Email", placeholder: "entrer un email");
  CustomTextField passWord = new CustomTextField(
      title: "Mot de pass", placeholder: "********", ispass: true);
  CustomTextField confPassWord = new CustomTextField(
      title: "Mot de pass", placeholder: "********", ispass: true);
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    nomText.err = "entrer un nom";
    emailText.err = "entrer un e-mail";
    passWord.err = "entrer un mot de passe";
    confPassWord.err = "confirmer le mot de passe";
    return Scaffold(
      backgroundColor: Color(0xFFE0E0E0),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            // ignore: prefer_const_constructors
            padding: EdgeInsets.all(30),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "S'inscrire",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                  SizedBox(height: 25),
                  nomText.textformfield(),
                  SizedBox(height: 25),
                  emailText.textformfield(),
                  SizedBox(height: 10),
                  passWord.textformfield(),
                  SizedBox(height: 10),
                  confPassWord.textformfield(),
                  SizedBox(height: 10),
                  RaisedButton(
                    onPressed: () {
                      register(nomText.value, emailText.value, passWord.value);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "S'insrire",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    color: Colors.blueAccent.withOpacity(.5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Avez-vous un compte?",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      FlatButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage(),
                            )),
                        child: Text(
                          "Se connecter",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
