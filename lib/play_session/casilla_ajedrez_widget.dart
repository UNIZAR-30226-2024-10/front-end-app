//Nombre: casilla_ajedrez.dart
//Descripción: Contiene el widget de la casilla de ajedrez.

import 'package:flutter/material.dart';
import 'package:basic/play_session/pieza_ajedrez_widget.dart';

class CasillaAjedrez extends StatelessWidget {
  final Color color;
  final bool ocupada;
  final TipoPieza? pieza;

  const CasillaAjedrez({
    Key? key,
    required this.color,
    required this.ocupada,
    this.pieza,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container (width: 40,
        height: 40,
        color: color,
        ),
        PiezaAjedrez(tipo: TipoPieza.caballo, color: Colors.brown),
      ]
    );
  }
}



