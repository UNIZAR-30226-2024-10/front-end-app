import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class FinPartida extends StatelessWidget {
  final bool esColorBlanca;
  final bool esJaqueMate;

  const FinPartida({
    Key? key,
    this.esColorBlanca = false,
    this.esJaqueMate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String mensajeFinal = esJaqueMate
        ? 'Jaque Mate\nGanan las piezas ${esColorBlanca ? 'Negras' : 'Blancas'}'
        : 'Rey ahogado\nEmpate\nNingún jugador gana';

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 450,
          height: 400,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.orange[900]!, Colors.orange[300]!],
            ),
            borderRadius: BorderRadius.circular(10), // Bordes redondeados
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              ElevatedButton(
                onPressed: () {
                  // Navegar a la ruta deseada al abandonar la partida
                  GoRouter.of(context).go('/chess');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[900]!,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Abandonar partida',
                  style: GoogleFonts.play(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
