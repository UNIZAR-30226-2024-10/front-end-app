import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ChessHub/play_session/pieza_ajedrez.dart';
import 'package:ChessHub/game_internals/funciones.dart';

class PiezaCoronar extends StatelessWidget {
  final bool esBlanca;
  final TipoPieza tipoPieza;

  PiezaCoronar({required this.esBlanca, required this.tipoPieza});

  @override
  Widget build(BuildContext context) {
    String imagePath = obtenerRutaImagen(tipoPieza, esBlanca);

    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: esBlanca ? Colors.black : Colors.white,
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: SvgPicture.asset(
          imagePath,
          width: 40,
          height: 40,
        ),
      ),
    );
  }
}
