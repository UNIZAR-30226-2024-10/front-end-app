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
      case TipoPieza.PEON:
        return "P";
      case TipoPieza.TORRE:
        return "T";
      case TipoPieza.ALFIL:
        return "A";
      case TipoPieza.CABALLO:
        return "C";
      case TipoPieza.DAMA:
        return "D";
      case TipoPieza.REY:
        return "REY";
      case TipoPieza.REINA:
        return "REINA";
      default:
        return "";
    }
  }
}

