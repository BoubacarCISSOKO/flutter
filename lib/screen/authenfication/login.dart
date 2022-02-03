// ignore_for_file: use_key_in_widget_constructors, import_of_legacy_library_into_null_safe, prefer_final_fields, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, non_constant_identifier_names, unused_element, unused_local_variable

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:myapp6login/screen/authenfication/registe2.dart';
//import http package manually

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  late String errormsg;
  late bool error, showprogress;
  late String username, password;
  late int id;

  var _username = TextEditingController();
  var _password = TextEditingController();

  startLogin() async {
    String apiurl =
        "https://projetmody.000webhostapp.com/article/userlogin.php"; //api url

    print(username);

    var response = await http.post(Uri.parse(apiurl),
        headers: {"Accept": "application/json"},
        body: {'name': username, 'password': password});

    if (response.statusCode == 200) {
      setState(() {
        error = false;
        showprogress = false;
        errormsg = "connection réussie !";
      });
    } else {
      setState(() {
        showprogress = false;
        error = true;
        errormsg = "erreur";
      });
    }
  }

  void _Redirection() async {
    await startLogin();

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    username = "";
    password = "";
    errormsg = "";
    error = false;
    showprogress = false;

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
        padding: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              "Connection",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ), //title text
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              "Connectez-vous à l’aide de votre adresse e-mail et votre mot de passe",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ), //subtitle text
          ),
          Container(
            //show error message here
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.all(10),
            child: error ? errmsg(errormsg) : Container(),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              controller: _username,
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
                password = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 10),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  if (username.isEmpty || password.isEmpty) {
                    _showDialog(context);
                  } else {
                    setState(() {
                      showprogress = false;
                      error = false;
                    });
                    _Redirection();
                  }
                },
                child: showprogress
                    ? SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blue[100],
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.lightBlueAccent),
                        ),
                      )
                    : Text(
                        "Se Connecter",
                        style: TextStyle(fontSize: 20),
                      ),
                colorBrightness: Brightness.dark,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                    onPressed: () {},
                    child: Text(
                      "Mot de pass oublié?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                FlatButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Register2(),
                        )),
                    child: Text(
                      "S'inscrire",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ))
              ],
            ),
          ),
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
