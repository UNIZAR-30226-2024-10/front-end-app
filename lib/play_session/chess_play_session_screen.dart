//Nombre: chess_play_session_screen.dart
//Descripción: Contiene la pantalla de juego de ajedrez.

import 'package:flutter/material.dart';
import 'package:ChessHub/style/header.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ChessHub/constantes/constantes.dart';

class ChessPlaySessionScreen extends StatelessWidget {
  const ChessPlaySessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                child: ListView(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        //CONTENEDOR DEL JUEGO EN LOCAL
                        width: 450,
                        height: 400,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.orange[900]!, Colors.orange[300]!],
                          ),
                        ),
                        child: Column(children: [
                          SizedBox(height: 30),
                          Align(
                              alignment: Alignment.topCenter,
                              child: Text('JUGAR EN MODO LOCAL',
                                  style: GoogleFonts.play(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ))),
                          SizedBox(height: 30),
                          GestureDetector(
                            onTap: () {
                              context.go('juegoLocalRAPID');
                            },
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'RAPID',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: 'Cantarell',
                                  ),
                                )),
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text('-',
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.black,
                                    fontFamily: 'Cantarell',
                                    fontWeight: FontWeight.bold,
                                  ))),
                          GestureDetector(
                            onTap: () {
                              context.go('juegoLocalBULLET');
                            },
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'BULLET',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: 'Cantarell',
                                  ),
                                )),
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text('-',
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.black,
                                    fontFamily: 'Cantarell',
                                    fontWeight: FontWeight.bold,
                                  ))),
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context).go('juegoLocalBLITZ');
                            },
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'BLITZ',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: 'Cantarell',
                                  ),
                                )),
                          ),
                        ])),
                    SizedBox(height: 20),
                    Container(
                        width: 450,
                        height: 400,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.orange[900]!, Colors.orange[300]!],
                          ),
                        ),
                        child: Column(children: [
                          SizedBox(height: 30),
                          Align(
                              alignment: Alignment.topCenter,
                              child: Text('JUGAR EN MODO ONLINE',
                                  style: GoogleFonts.play(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ))),
                          SizedBox(height: 30),
                          Align(
                              alignment: Alignment.center,
                              child: Text('RAPID',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: 'Cantarell',
                                  ))),
                          Align(
                              alignment: Alignment.center,
                              child: Text('-',
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.black,
                                    fontFamily: 'Cantarell',
                                    fontWeight: FontWeight.bold,
                                  ))),
                          Align(
                              alignment: Alignment.center,
                              child: Text('BULLET',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: 'Cantarell',
                                  ))),
                          Align(
                              alignment: Alignment.center,
                              child: Text('-',
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.black,
                                    fontFamily: 'Cantarell',
                                    fontWeight: FontWeight.bold,
                                  ))),
                          Align(
                              alignment: Alignment.center,
                              child: Text('BLITZ',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: 'Cantarell',
                                  ))),
                        ])),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
