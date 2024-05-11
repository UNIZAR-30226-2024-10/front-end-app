import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:ChessHub/local_game_sesion/chess_play_session_screen.dart';

class FinPartidaOnline extends StatelessWidget {
  final String razon;

  const FinPartidaOnline({
    Key? key,
    this.razon = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String mensajeFinal = '';
    switch (razon) {
      case "player_disconnected":
        mensajeFinal = ' !Ganas!\nTu oponente se ha desconectado';
      case "oponent_surrendered":
        mensajeFinal = ' !Ganas!\nTu oponente se ha rendido';
      case "has_perdido":
        mensajeFinal = ' !Jaque Mate!\nTu oponente ha ganado';
      case "has_empatado":
        mensajeFinal = ' !Empate!\nLa partida ha terminado en empate';
      case "has_ganado":
        mensajeFinal = ' !Ganas!\nHas ganado la partida';
      case "has_perdido_timer":
        mensajeFinal = ' !Has perdido!\nHas superado el tiempo límite';
      case "has_ganado_timer":
        mensajeFinal = ' !Ganas!\nTu oponente ha superado el tiempo límite';
      default:
        mensajeFinal = ' !Fin de la partida!';
        break;
    }
    

    return Scaffold(
      backgroundColor: Color.fromRGBO(49, 45, 45, 1),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChessPlaySessionScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
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
