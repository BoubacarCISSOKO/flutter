// ignore_for_file: use_key_in_widget_constructors, import_of_legacy_library_into_null_safe, prefer_final_fields, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, unused_field, non_constant_identifier_names, unused_element

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:myapp6login/screen/authenfication/login.dart';

class Register2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Register2();
  }
}

class _Register2 extends State<Register2> {
  late String errormsg;
  late bool error, showprogress;
  late String username, useremail, passWord, confirmPass;

  var _username = TextEditingController();
  var _useremail = TextEditingController();
  var _password = TextEditingController();
  var _confirmPass = TextEditingController();

  startRegister(String username, String useremail, String passWord) async {
    String apiurl = "https://projetmody.000webhostapp.com/article/register.php";

    print(username);

    var response = await http.post(Uri.parse(apiurl),
        body: {'name': username, 'email': useremail, 'pass': passWord});
    if (response.statusCode == 200) {
      print("OK");
    } else {
      print('Échec !');
    }
  }

  void _Redirection(context) async {
    await startRegister(username, useremail, passWord);

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    username = "";
    useremail = "";
    passWord = "";
    confirmPass = "";
    errormsg = "";
    error = false;
    showprogress = false;

    //_username.text = "defaulttext";
    //_password.text = "defaultpassword";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Padding(padding: EdgeInsets.all(5)),
            Text(
              'POSTEMARKET 3.0',
              style: TextStyle(fontSize: 25),
            ),
            Padding(padding: EdgeInsets.only(left: 5.0, right: 5.0)),
            Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.blueAccent,
              Colors.blueGrey,
              Colors.lightBlue,
            ],
          ),
        ),
        padding: EdgeInsets.all(5),
        child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              "Création de compte",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ), //title text
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Text(
              "Renseignez vos information",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ), //subtitle text
          ),
          Container(
            //show error message here
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(5),
            child: error ? errmsg(errormsg) : Container(),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              controller: _username, //set username controller
              style: TextStyle(color: Colors.white, fontSize: 20),
              decoration: myInputDecoration(
                label: "Nom",
                icon: Icons.person,
              ),
              onChanged: (value) {
                username = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              controller: _useremail,
              style: TextStyle(color: Colors.white, fontSize: 20),
              decoration: myInputDecoration(
                label: "E-mail",
                icon: Icons.email,
              ),
              onChanged: (value) {
                useremail = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _password,
              style: TextStyle(color: Colors.white, fontSize: 20),
              obscureText: true,
              decoration: myInputDecoration(
                label: "Mot de pass",
                icon: Icons.lock,
              ),
              onChanged: (value) {
                // change password text
                passWord = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _confirmPass,
              style: TextStyle(color: Colors.white, fontSize: 20),
              obscureText: true,
              decoration: myInputDecoration(
                label: "Confirmer le mot de pass",
                icon: Icons.lock,
              ),
              onChanged: (value) {
                confirmPass = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(top: 10),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  if (username.isEmpty ||
                      useremail.isEmpty ||
                      passWord.isEmpty ||
                      confirmPass.isEmpty) {
                    _showDialog(context);
                  } else {
                    if (passWord == confirmPass) {
                      _Redirection(context);
                    } else {
                      _showPassDialog(context);
                    }
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                    //button corner radius
                    ),
                child: Text(
                  "S'insrire",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                color: Colors.blueAccent.withOpacity(.5),
                colorBrightness: Brightness.dark,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 20),
            child: InkResponse(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage(),
                    )),
                child: Text(
                  "Avez-vous un compte? Se connecter",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
          )
        ]),
      )),
    );
  }

  InputDecoration myInputDecoration(
      {required String label, required IconData icon}) {
    return InputDecoration(
      hintText: label, //show label as placeholder
      hintStyle: TextStyle(color: Colors.white, fontSize: 20), //hint text style
      prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 10),
          child: Icon(
            icon,
            color: Colors.white,
          )),

      contentPadding: EdgeInsets.fromLTRB(30, 20, 30, 20),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blue, width: 1)),

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blue, width: 1)),

      fillColor: Colors.black12,
      filled: true,
    );
  }

  Widget errmsg(String text) {
    //widget message erreur.
    return Container(
      padding: EdgeInsets.all(15.00),
      margin: EdgeInsets.only(bottom: 10.00),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.red,
          border: Border.all(color: Colors.red, width: 2)),
      child: Row(children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 6.00),
          child: Icon(Icons.info, color: Colors.white),
        ),
        Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
      ]),
    );
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Les champs sont obligatoires!!"),
        content: Text("Veuillez les renseigner"),
        actions: <Widget>[
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _showPassDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Les mots de sont différents"),
        content: Text("Veuillez saisir le même mot de pass"),
        actions: <Widget>[
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
