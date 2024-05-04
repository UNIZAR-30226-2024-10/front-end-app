import 'dart:convert';
import 'package:flutter/material.dart';
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

class RankingScreenBlitz extends StatefulWidget {
  @override
  _RankingScreenStateBlitz createState() => _RankingScreenStateBlitz();
}

class _RankingScreenStateBlitz extends State<RankingScreenBlitz> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchLeaderBoard();
  }

  Future<void> fetchLeaderBoard() async {
    final url = Uri.parse('http://192.168.1.97:3001/users/ranking/blitz');
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ranking BLITZ',
          style: TextStyle(color: Colors.white, fontFamily: 'Oswald'),
        ),
        backgroundColor: Color.fromRGBO(49, 45, 45, 1),
      ),
      backgroundColor: Colors.black,
      body: Container(
        color: Color.fromRGBO(49, 45, 45, 1),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            User user = users[index];
            // Define el color de fondo de la caja
            Color tileColor = Colors.transparent;
            if (user.nombre == 'calvera') {
              tileColor = Colors.orange[200]!;
            }
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Card(
                elevation: 3,
                child: ListTile(
                  title: Text(
                    '${index + 1}.\t ${user.nombre}.\t${user.elo} pts',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  // Establece el color de fondo de la caja
                  tileColor: tileColor,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
