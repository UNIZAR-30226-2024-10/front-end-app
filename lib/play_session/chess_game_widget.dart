//Nombre: chess_game_widget.dart
//Descripción: Contiene el widget del juego de ajedrez.


import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

class ChessGameWidget extends StatelessWidget {
  const ChessGameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 320,
      color: Colors.brown,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
        ),
        itemBuilder: (context, index) {
          final color = (index ~/ 8 + index % 8) % 2 == 0
              ? Colors.white
              : Colors.black;
          return CasillaAjedrez(color: color);
        },
      ),
    );
  }
}

class CasillaAjedrez extends StatelessWidget {
  final Color color;

  const CasillaAjedrez({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      color: color,
    );
  }
}



