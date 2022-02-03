// ignore_for_file: unnecessary_new, unused_import, prefer_const_constructors, duplicate_ignore, sized_box_for_whitespace, deprecated_member_use, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, avoid_print, duplicate_import, file_names
// @dart=2.9
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp6login/screen/authenfication/login.dart';
import 'package:myapp6login/screen/authenfication/registe2.dart';
import 'package:myapp6login/screen/authenfication/register.dart';

Future<List<User>> fetchUser() async {
  List<User> todoList = [];

  final response = await http.get(
      Uri.parse(
          'https://projetmody.000webhostapp.com/article/registerselect.php'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
      });

  if (response.statusCode == 200) {
    var tableau = json.decode(response.body);

    for (var unElement in tableau) {
      todoList.add(User.fromJson(unElement));
    }
  } else {
    throw Exception('Failed to load album');
  }
  return todoList;
}

//int.tryParse("id")
//int.Parse("id")

void updateUser(
  int id,
  String nomText,
  String emailText,
) async {
  var url = 'https://projetmody.000webhostapp.com/article/registerUpdate.php';
  var data = {"id": id, "name": nomText, "email": emailText};
  var res = await http.put(url, body: data);
  if (res.statusCode == 200) {
    print("Modifier");
  } else {
    print('Échec !! Pas d\'autorisation');
  }
}

void deleteUser(int id) async {
  var url = 'https://projetmody.000webhostapp.com/article/registerDelete.php';
  var data = {"id": id};
  var res = await http.post(url, body: data);
  if (res.statusCode == 200) {
    print("Supprimé!");
  } else {
    print('Échec !! Pas d\'autorisation');
  }
}

class User {
  final int id;
  final String name;
  final String email;

  User({this.id, this.name, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<User>> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        margin: const EdgeInsets.only(left: 5.0, right: 5.0),
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              List<User> todoList = snapshot.data;
              return ListView.builder(
                itemBuilder: (_, position) {
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.all(3.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      title: Text(todoList[position].name),
                      subtitle: Text(todoList[position].email),
                      onTap: () {},
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                //affichage de la boite de dialogue pour la suppression
                              }),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: todoList.length,
              );
            } else {
              // ignore: prefer_const_constructors
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          future: fetchUser(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Register2(),
            )),
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Acceuil"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("IRATIC"),
          ),
        ],
      ),
    );
  }
}
