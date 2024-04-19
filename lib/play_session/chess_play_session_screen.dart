//Nombre: chess_play_session_screen.dart
//Descripción: Contiene la pantalla de juego de ajedrez.

import 'package:ChessHub/play_session/tablero_widget.dart';
import 'package:ChessHub/style/my_button.dart';
import 'package:flutter/material.dart';
import 'package:ChessHub/style/header.dart';

class ChessPlaySessionScreen extends StatelessWidget {
  const ChessPlaySessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
    );
  }
}