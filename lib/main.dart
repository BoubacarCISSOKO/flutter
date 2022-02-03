// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unnecessary_new, prefer_const_literals_to_create_immutables
// @dart=2.9

import 'package:flutter/material.dart';
import 'package:myapp6login/screen/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
        body: Center(
          child: HomePage(),
        ),
      ),
    );
  }
}
