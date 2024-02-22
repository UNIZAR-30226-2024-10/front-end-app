//Nombre: chess_game_widget.dart
//Descripción: Contiene el widget del juego de ajedrez.


import 'package:flutter/material.dart';
import 'package:basic/play_session/tablero_widget.dart';
//import 'package:provider/provider.dart';

class ChessGameWidget extends StatelessWidget {
  final bool partidaIniciada;

  const ChessGameWidget({
    Key? key,
    this.partidaIniciada = false,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TableroWidget(),
      ],
    );
  }
}
