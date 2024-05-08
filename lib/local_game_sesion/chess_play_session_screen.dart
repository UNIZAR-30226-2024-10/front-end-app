import 'package:ChessHub/constantes/constantes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ChessHub/online_game_sesion/tablero_online_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ChessHub/style/header.dart';
import 'package:ChessHub/log_in/log_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:ChessHub/local_game_sesion/pieza_ajedrez.dart';
import 'package:ChessHub/game_internals/funciones.dart';
import 'dart:async';


class ChessPlaySessionScreen extends StatelessWidget {
  const ChessPlaySessionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final login = context.read<LoginState>();
    bool cuentalog = false;
    List<List<PiezaAjedrez?>> tablero = List.generate(8, (index) => List.generate(8, (index) => null));
    List<Color> coloresTablero = [];
    if (login.logueado) {
      cuentalog = true;
      print("ARENA: ${login.arena}");
      print("COLOR: ${coloresTablero}");
      tablero = inicializarTablero(login.imagen);
      coloresTablero = getColorCasilla(login.arena);
    }
    return Consumer<LoginState>(
      builder: (context,value,child) => Scaffold(
        appBar: Header(),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: [Color.fromRGBO(49, 45, 45, 1), Colors.grey[500]!],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 450,
                          height: 400,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.orange[900]!, Colors.orange[300]!],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'JUGAR EN MODO LOCAL',
                                style: GoogleFonts.play(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 30),
                              GestureDetector(
                                onTap: () {
                                  context.go('/chess/rapid');
                                },
                                child: Text(
                                  'RAPID',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: 'Cantarell',
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  context.go('/chess/bullet');
                                },
                                child: Text(
                                  'BULLET',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: 'Cantarell',
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  GoRouter.of(context).go('/chess/blitz');
                                },
                                child: Text(
                                  'BLITZ',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: 'Cantarell',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        cuentalog ?
                        Container(
                          width: 450,
                          height: 400,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.orange[900]!, Colors.orange[300]!],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'JUGAR EN MODO ONLINE',
                                style: GoogleFonts.play(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 30),
                              GestureDetector(
                                onTap: () async{
                                  bool partidaEncontrada = false;
                                  login.enviarPeticiondeJuego(Modos.RAPID);
                                  login.socket.on('match_found', (data) {
                                    partidaEncontrada = true;
                                  });
                                  while (!partidaEncontrada) {
                                    await Future.delayed(Duration(seconds: 1));
                                  }
                                  print("Partida encontrada: $partidaEncontrada");
                                 
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TableroAjedrezOnline(modoJuego: Modos.RAPID,coloresTablero: coloresTablero, tablero: tablero)
                                    ),
                                  );
                                },
                                child: Text(
                                  'RAPID',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: 'Cantarell',
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  final login = context.read<LoginState>();
                                  login.getInfo(login.getId());
                                  List<List<PiezaAjedrez?>> tablero;
                                  List<Color> coloresTablero;
                                  tablero = inicializarTablero(login.imagen);
                                  coloresTablero = getColorCasilla(login.arena);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TableroAjedrezOnline(modoJuego: Modos.BULLET,coloresTablero: coloresTablero, tablero: tablero)
                                    ),
                                  );
                                },
                                child: Text(
                                  'BULLET',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: 'Cantarell',
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  final login = context.read<LoginState>();
                                  login.getInfo(login.getId());
                                  List<List<PiezaAjedrez?>> tablero;
                                  List<Color> coloresTablero;
                                  tablero = inicializarTablero(login.imagen);
                                  coloresTablero = getColorCasilla(login.arena);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TableroAjedrezOnline(modoJuego: Modos.BLITZ,coloresTablero: coloresTablero, tablero: tablero)
                                    ),
                                  );
                                },
                                child: Text(
                                  'BLITZ',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: 'Cantarell',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        : Container(
                          child:
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  'CREATE UNA CUENTA PARA JUGAR ONLINE',
                                  style: GoogleFonts.play(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                      ],
                    ),
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
