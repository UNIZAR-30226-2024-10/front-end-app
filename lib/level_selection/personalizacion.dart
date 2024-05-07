import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../style/my_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Set {
  final String name;
  final int level;
  Set({
    required this.name,
    required this.level,
  });
}

final List<Set> sets = [
  Set(name: 'alpha', level: 2),
  Set(name: 'cardinal',level: 4),
  Set(name: 'celtic', level: 6),
  Set(name: 'chess7', level: 8),
  Set(name: 'chessnut', level: 10),
  Set(name: 'companion', level: 12),
  Set(name: 'fantasy', level: 14),
  Set(name: 'fresca', level: 16),
  Set(name: 'governor', level: 18),
  Set(name: 'kosal', level: 20),
  Set(name: 'leipzig', level: 22),
  Set(name: 'mpchess', level: 24),
  Set(name: 'pixel', level: 26),
  Set(name: 'maestro', level: 28),
  Set(name: 'anarcandy', level: 30),
];

class Emote {
  final String emoji;
  final int level;
  Emote({
    required this.emoji,
    required this.level,
  });
}

final List<Emote> emotes = [
  Emote(emoji: '😁️', level: 1),
  Emote(emoji: '😂️', level: 3),
  Emote(emoji: '👍️', level: 5),
  Emote(emoji: '😎️', level: 7),
  Emote(emoji: '😭️', level: 9),
  Emote(emoji: '😅️', level: 11),
  Emote(emoji: '👊️', level: 13),
  Emote(emoji: '🤩️', level: 15),
  Emote(emoji: '🤯️', level: 17),
  Emote(emoji: '😜️', level: 19),
  Emote(emoji: '🫠️', level: 21),
  Emote(emoji: '😎️', level: 23),
  Emote(emoji: '😡️', level: 25),
  Emote(emoji: '😈️', level: 27),
  Emote(emoji: '👻️', level:29),
];

class Personalizacion extends StatelessWidget {
  bool _isSwitched = false;
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
      DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(49, 45, 45, 1),
            title: Text('Personalización',
                style: TextStyle(color: Colors.white, fontFamily: 'Oswald')),
            bottom: const TabBar(
              labelColor: Color.fromRGBO(255, 136, 0, 1),
              indicatorColor: Color.fromRGBO(255, 136, 0, 1),
              overlayColor: MaterialStatePropertyAll(Colors.transparent),
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.brush),
                ),
                Tab(
                  icon: Icon(Icons.emoji_emotions),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                color: Colors.transparent,
                child: ListView.builder(
                  itemCount: sets.length,
                  itemBuilder: (context, index) {
                    final set = sets[index];

                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      color: Color.fromRGBO(49, 45, 45,
                          1), // Cambia el color de fondo de la tarjeta
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${set.name}',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/images_pase/pieces/${set.name}/bK.svg',
                                  width: 42,
                                  height: 42,
                                ),
                                SvgPicture.asset(
                                  'assets/images/images_pase/pieces/${set.name}/wQ.svg',
                                  width: 42,
                                  height: 42,
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                                onPressed: () {
                                  // Aquí puedes programar la lógica para el botón de este componente
                                  // Por ejemplo, puedes navegar a otra pantalla, realizar una acción, etc.
                                },
                                child: Text('Activar', style: TextStyle(color: Color.fromARGB(255, 112, 112, 112))),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                color: Colors.transparent,
                child: ListView.builder(
                  itemCount: emotes.length,
                  itemBuilder: (context, index) {
                    final emote = emotes[index];

                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      color: Color.fromRGBO(49, 45, 45,
                          1), // Cambia el color de fondo de la tarjeta
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${emote.emoji}',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                                onPressed: () {
                                  // Aquí puedes programar la lógica para el botón de este componente
                                  // Por ejemplo, puedes navegar a otra pantalla, realizar una acción, etc.
                                },
                                child: Text('Activar', style: TextStyle(color: Color.fromARGB(255, 112, 112, 112))),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
