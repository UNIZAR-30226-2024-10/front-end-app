import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../style/header.dart';

class Arenas extends StatefulWidget {
  @override
  _ArenasState createState() => _ArenasState();
}

class Arena {
  final int level;
  final int elo;
  final int elo2;

  Arena({
    required this.level,
    required this.elo,
    required this.elo2,
  });
}

final List<Arena> tiers = [
  Arena(level: 1, elo: 0, elo2: 1000),
  Arena(level: 2, elo: 1000, elo2: 1200),
  Arena(level: 3, elo: 1200, elo2: 1400),
  Arena(level: 4, elo: 1400, elo2: 1600),
  Arena(level: 5, elo: 1600, elo2: 1800),
];

class _ArenasState extends State<Arenas> {
  @override
  Widget build(BuildContext context) {
    // Ordenar los tiers por nivel
    tiers.sort((a, b) => a.level.compareTo(b.level));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/board.jpg"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(49, 45, 45, 1),
            title: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                'ChessHub',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ),
          ),
          body: Container(
            color: Colors.transparent,
            child: ListView.builder(
              itemCount: tiers.length,
              itemBuilder: (context, index) {
                final tier = tiers[index];

                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: Color.fromRGBO(
                      49, 45, 45, 1), // Cambia el color de fondo de la tarjeta
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Arena ${tier.level}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                                'Elo requerido: ${tier.elo}' +
                                    ' - ' +
                                    '${tier.elo2}',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.orange)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Centra las imágenes y los emoticonos
                          children: [
                            Image(
                              image: AssetImage(
                                  'assets/images/images_pase/boards/arena_${tier.level}.jpg'),
                              width: 300,
                              height: 300,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }
}
