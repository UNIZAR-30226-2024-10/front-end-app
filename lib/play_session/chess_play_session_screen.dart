//Nombre: chess_play_session_screen.dart
//Descripción: Contiene la pantalla de juego de ajedrez.

import 'package:basic/play_session/chess_game_widget.dart';
import 'package:basic/style/my_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class ChessPlaySessionScreen extends StatefulWidget {

  const ChessPlaySessionScreen({super.key});

  @override
  State<ChessPlaySessionScreen> createState() => _ChessPlaySessionScreenState();
}

class _ChessPlaySessionScreenState extends State<ChessPlaySessionScreen>{
  //static final _log = Logger('ChessPlaySessionScreen');
  static const _gap = SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    //final palette = context.watch<Palette>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('En construcción'),
            _gap,
            ChessGameWidget(),
            _gap,
            MyButton(
              onPressed: () => GoRouter.of(context).go('/'),
              child: const Text('Back'),
            ),
          ],
        ),
      ),

    );
  }
}