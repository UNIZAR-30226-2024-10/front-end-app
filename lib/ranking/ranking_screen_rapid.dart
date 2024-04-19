import 'package:flutter/material.dart';
import '../style/header.dart';

class User {
  final String name;
  final int points;
  final int puesto;

  User({required this.name, required this.points, required this.puesto});
}

class RankingScreenRapid extends StatefulWidget {
  @override
  _RankingScreenStateRapid createState() => _RankingScreenStateRapid();
}

class _RankingScreenStateRapid extends State<RankingScreenRapid> {
  final List<User> users = [
    User(name: 'elrey900', points: 150, puesto: 1),
    User(name: 'gambito18', points: 120, puesto: 2),
    // Añade más usuarios aquí...
    User(name: 'elxokas', points: 117, puesto: 3),
    User(name: 'user1231', points: 113, puesto: 4),
    User(name: 'bot1', points: 100, puesto: 5),
    User(name: 'Pablo34', points: 96, puesto: 6),
    User(name: 'Bot de Nunu', points: 92, puesto: 7),
    User(name: 'jose', points: 87, puesto: 8),
    User(name: '8325235a', points: 83, puesto: 9),
    User(name: 'alberto', points: 81, puesto: 10),
    User(name: 'cr7', points: 79, puesto: 11),

  ];

  @override
  Widget build(BuildContext context) {
    // Ordena la lista de usuarios por puntos en orden descendente
    users.sort((a, b) => b.points.compareTo(a.points));

    // Encuentra la posición del usuario actual en la lista
    int userIndex = users.indexWhere((user) => user.name == 'Pablo34');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ranking RAPID',
          style: TextStyle(color: Colors.white,fontFamily: 'Oswald'),
        ),
        backgroundColor: Color.fromRGBO(49,45,45,1),
      ),
      backgroundColor: Colors.black,
      body: Container(
        color: Color.fromRGBO(58, 58, 58, 1),
        child: ListView.builder(
          itemCount: 51,
          itemBuilder: (context, index) {
            // Calcula el índice real en la lista de usuarios
            int realIndex = index - 25 + userIndex;

            // Verifica si el índice está dentro de los límites de la lista de usuarios
            if (realIndex >= 0 && realIndex < users.length) {
              User user = users[realIndex];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Card(
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      '${user.puesto}. ${user.name}   ${user.points} pts',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), 
                    ),
                    // Personaliza el estilo del usuario actual
                    tileColor: realIndex == userIndex ? Colors.orange[200] : null,
                  ),
                ),
              );
            } else {
              // Muestra un contenedor vacío para los elementos que están fuera de la lista de usuarios
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}