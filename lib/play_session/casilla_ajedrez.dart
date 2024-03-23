//Nombre: casilla_ajedrez.dart
//Descripción: Contiene el widget de la casilla de ajedrez.

import 'package:flutter/material.dart';
import 'package:basic/play_session/pieza_ajedrez.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CasillaAjedrez extends StatelessWidget {
  final PiezaAjedrez? pieza;
  final bool esBlanca;
  final bool seleccionada;
  final void Function()? onTap;

  const CasillaAjedrez({
    Key? key,
    this.pieza,
    required this.esBlanca,
    required this.seleccionada,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? colorCasilla;

    if (seleccionada) {
      colorCasilla = const Color.fromARGB(255, 223, 85, 75);
    } else {
      colorCasilla =
          colorCasilla = esBlanca ? Color(0xFFADF597) : Color(0XFF2E960F);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: colorCasilla,
        child: pieza != null
            ?
            //adaptar la imagen de la pieza
            SvgPicture.asset(
                pieza!.nombreImagen,
                width: 24, // Ajusta el tamaño según sea necesario
                height: 24,
              )
            : null,
      ),
    );
  }
}
