//Nombre: casilla_ajedrez.dart
//Descripción: Contiene el widget de la casilla de ajedrez.

import 'package:flutter/material.dart';
import 'package:basic/play_session/pieza_ajedrez.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CasillaAjedrez extends StatelessWidget {
  final PiezaAjedrez? pieza;
  final bool esBlanca;

  const CasillaAjedrez({
    Key? key,
    this.pieza,
    required this.esBlanca,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:esBlanca ? Color(0xFFADF597) : Color(0XFF2E960F),
      child: pieza != null ? 
      //adaptar la imagen de la pieza
      
      SvgPicture.asset(
              pieza!.nombreImagen,
              width: 24, // Ajusta el tamaño según sea necesario
              height: 24,
            )
          : null,
    );
  }
}