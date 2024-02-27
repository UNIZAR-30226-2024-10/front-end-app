//Nombre: casilla_ajedrez.dart
//Descripción: Contiene el widget de la casilla de ajedrez.

import 'package:flutter/material.dart';
import 'package:basic/play_session/pieza_ajedrez_widget.dart';
import 'package:basic/assets/constantes/constantes.dart';

class CasillaAjedrez extends StatefulWidget {
  final Color colorCasilla;
  final bool ocupada;
  final int index;
  final TipoPieza? pieza;

  const CasillaAjedrez({
    Key? key,
    required this.colorCasilla,
    required this.ocupada,
    required this.index,
    this.pieza,
  }) : super(key: key);

  @override
  _CasillaAjedrezState createState() => _CasillaAjedrezState();
}

class _CasillaAjedrezState extends State<CasillaAjedrez> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 40,
          height: 40,
          color: widget.colorCasilla,
        ),
        if (widget.ocupada && widget.index >= 0 && widget.index <16)
          (PiezaAjedrez(tipo: widget.pieza!, color: Colors.black)),
        if (widget.ocupada && widget.index >= 48 && widget.index <64)
          (PiezaAjedrez(tipo: widget.pieza!, color: Colors.grey)),
      ],
    );
  }
}
