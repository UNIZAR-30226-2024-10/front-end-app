//Nombre: pieza_ajedrez.dart
//Descripción: Contiene el widget de la pieza de ajedrez.

import 'package:flutter/material.dart';
import 'package:basic/assets/constantes/constantes.dart';

class PiezaAjedrez extends StatelessWidget {
  final TipoPieza tipo;
  final Color color;

  const PiezaAjedrez({
    Key? key,
    required this.tipo,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          getPiezanombre(tipo), // Función para convertir tipo a nombre
          style: TextStyle(fontSize: 8, color: color),
        ),
      ),
    );
  }

  String getPiezanombre(TipoPieza tipo) {
    switch (tipo) {
      case TipoPieza.peon:
        return "P";
      case TipoPieza.torre:
        return "T";
      case TipoPieza.alfil:
        return "A";
      case TipoPieza.caballo:
        return "C";
      case TipoPieza.dama:
        return "D";
      case TipoPieza.rey:
        return "REY";
      case TipoPieza.reina:
        return "REINA";
      default:
        return "";
    }
  }
}

