//Nombre: pieza_ajedrez.dart
//Descripción: Contiene el widget de la pieza de ajedrez.

import 'package:flutter/material.dart';
import 'package:basic/assets/constantes/constantes.dart';
import 'package:flutter_svg/flutter_svg.dart';



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
    String assetPath = getAssetPath(tipo, color); // Función para obtener la ruta del archivo SVG
    return Container(
      child: Center(
        child: SvgPicture.asset(
          assetPath,
          width: 40, // Ajusta el tamaño según sea necesario
          height: 40,
        ),
      ),
    );
  }

  String getAssetPath(TipoPieza tipo, Color color) {
    switch (tipo) {
      case TipoPieza.PEON:
        return color == Colors.black
            ? 'lib/assets/images/pawn-b.svg' // Ruta del archivo SVG del peón
            : 'lib/assets/images/pawn-w.svg'; // Ruta del archivo SVG del peón
      case TipoPieza.TORRE:
        return color == Colors.black
            ? 'lib/assets/images/rook-b.svg' // Ruta del archivo SVG de la torre
            : 'lib/assets/images/rook-w.svg'; // Ruta del archivo SVG de la torre
      case TipoPieza.ALFIL:
        return color == Colors.black
            ? 'lib/assets/images/bishop-b.svg' // Ruta del archivo SVG del alfil
            : 'lib/assets/images/bishop-w.svg'; // Ruta del archivo SVG del alfil
      case TipoPieza.CABALLO:
        return color == Colors.black
            ? 'lib/assets/images/knight-b.svg' // Ruta del archivo SVG del caballo
            : 'lib/assets/images/knight-w.svg'; // Ruta del archivo SVG del caballo
      case TipoPieza.REY:
        return color == Colors.black
            ? 'lib/assets/images/king-b.svg' // Ruta del archivo SVG del rey
            : 'lib/assets/images/king-w.svg'; // Ruta del archivo SVG del rey
      case TipoPieza.REINA:
        return color == Colors.black
            ? 'lib/assets/images/queen-b.svg' // Ruta del archivo SVG de la reina
            : 'lib/assets/images/queen-w.svg'; // Ruta del archivo SVG de la reina
      default:
        return ''; // Devuelve una cadena vacía si el tipo de pieza es desconocido
    }
  }
}



