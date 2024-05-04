// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class User {
  final int id;
  final String nombre;
  final int elo;

  User({required this.id, required this.nombre, required this.elo});

  // Constructor factory para crear un objeto User desde un mapa JSON
  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        nombre = json['nombre'] as String,
        elo = json['elo'] as int;
}

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    super.initState();
    //usuario
  }

  /*void fetchLeaderBoard() async {
    final url = Uri.parse('http://localhost:3001/users/ranking/blitz');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final userMap = jsonDecode(response.body) as List<dynamic>;
      List<User> userList = [];
      userMap.forEach((userData) {
        userList.add(User.fromJson(userData as Map<String, dynamic>));
      });
      // Ordena la lista de usuarios por puntos en orden descendente
      userList.sort((a, b) => b.elo.compareTo(a.elo));
      setState(() {
        users = userList;
      });
    } else {
      throw Exception('Failed to load leaderboard');
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/board2.jpg"),
            fit: BoxFit.fill,
          ),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(49, 45, 45, 1),
          title: Text('Perfil de Usuario',
              style: TextStyle(color: Colors.white, fontFamily: 'Oswald')),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/Logo.png'),
              ),
              SizedBox(height: 16),
              Text(
                'Username',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(255, 136, 0, 1)),
              ),
              SizedBox(height: 8),
              Text(
                'Elo: 1800',
                style: TextStyle(
                    fontSize: 16, color: Color.fromRGBO(255, 136, 0, 1)),
              ),
              SizedBox(height: 16),
              Text(
                'W/L: 33/10',
                style: TextStyle(
                    fontSize: 16, color: Color.fromRGBO(255, 136, 0, 1)),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
