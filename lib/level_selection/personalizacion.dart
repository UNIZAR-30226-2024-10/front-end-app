import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../style/my_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Set {
  final String name;

  Set({
    required this.name,
  });
}

final List<Set> sets = [
  Set(name: 'alpha'),
  Set(name: 'cardinal'),
  Set(name: 'celtic'),
  Set(name: 'chess7'),
  Set(name: 'chessnut'),
  Set(name: 'companion'),
  Set(name: 'fantasy'),
  Set(name: 'fresca'),
  Set(name: 'governor'),
  Set(name: 'kosal'),
  Set(name: 'leipzig'),
  Set(name: 'mpchess'),
  Set(name: 'pixel'),
  Set(name: 'maestro'),
  Set(name: 'anarcandy'),
];

class Emote {
  final String emoji;

  Emote({
    required this.emoji,
  });
}

final List<Emote> emotes = [
  Emote(emoji: '😁️'),
  Emote(emoji: '😂️'),
  Emote(emoji: '👍️'),
  Emote(emoji: '😎️'),
  Emote(emoji: '😭️'),
  Emote(emoji: '😅️'),
  Emote(emoji: '👊️'),
  Emote(emoji: '🤩️'),
  Emote(emoji: '🤯️'),
  Emote(emoji: '😜️'),
  Emote(emoji: '🫠️'),
  Emote(emoji: '😎️'),
  Emote(emoji: '😡️'),
  Emote(emoji: '😈️'),
  Emote(emoji: '👻️'),
];

class Personalizacion extends StatelessWidget {
  bool _isSwitched = false;
  @override
  Widget build(BuildContext context) {
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
          DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Color.fromRGBO(49, 45, 45, 1),
                title: GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push('/');
                  },
                  child: Text(
                    'ChessHub',
                    style: TextStyle(
                        fontFamily: 'Oswald',
                        color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                ),
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
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                                )
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
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
        ]));
  }
}
