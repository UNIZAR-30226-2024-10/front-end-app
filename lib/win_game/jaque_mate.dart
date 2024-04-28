import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class JaqueMate extends StatelessWidget {
  final bool esColorBlanca;

  JaqueMate({
    Key? key,
    required this.esColorBlanca,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String colorGanador = esColorBlanca ? 'Blancas' : 'Negras';
    String mensajeFinal = 'Jaque Mate\nGanan las piezas\n $colorGanador';

    return Container(
      child: Center(
        child: Container(
          width: 450,
          height: 400,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1), // Borde negro de 1 píxel de ancho
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.orange[900]!, Colors.orange[300]!],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                mensajeFinal,
                textAlign: TextAlign.center,
                style: GoogleFonts.play(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  // Navegar a la ruta deseada al abandonar la partida
                  GoRouter.of(context).go('/chess');
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10), // Bordes redondeados
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Abandonar partida',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.play(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
