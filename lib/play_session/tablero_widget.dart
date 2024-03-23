//Nombre: tablero_screen.dart
//Descripción: Contiene la pantalla de juego de ajedrez.

import 'package:basic/play_session/pieza_ajedrez.dart';
import 'package:flutter/material.dart';
import 'package:basic/play_session/casilla_ajedrez.dart';
import 'package:basic/constantes/constantes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para manejar la codificación y decodificación JSON
import 'dart:io'; // Para leer archivos
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:basic/play_session/pieza_ajedrez.dart';
import 'package:basic/game_internals/funciones.dart';
//import 'package:basic/play_session/pieza_ajedrez_widget.dart';
//import 'package:provider/provider.dart';

class TableroAjedrez extends StatefulWidget {
  const TableroAjedrez({super.key});

  @override
  State<TableroAjedrez> createState() => _TableroAjedrezState();
}

class _TableroAjedrezState extends State<TableroAjedrez>{
  late List<List<PiezaAjedrez?>> tablero;

  @override
  void initState(){
    super.initState();
    _inicializarTablero();
  }

  void _inicializarTablero(){
    List<List<PiezaAjedrez?>> nuevoTablero = List.generate(8, (index) => List.generate(8, (index) => null));
    
    //Place pawn
    for(int i = 0; i < 8; i++){
      nuevoTablero[1][i] = PiezaAjedrez(
        tipoPieza: TipoPieza.PEONES,
        esBlanca: false,
        nombreImagen: 'assets/images/pawn-b.svg'
      );

      nuevoTablero[6][i] = PiezaAjedrez(
        tipoPieza: TipoPieza.PEONES,
        esBlanca: true,
        nombreImagen: 'assets/images/pawn-w.svg'
      );
    }

    //Place rooks
    nuevoTablero[0][0] = PiezaAjedrez(
      tipoPieza: TipoPieza.TORRES,
      esBlanca: false,
      nombreImagen: 'assets/images/rook-b.svg'
    );
    nuevoTablero[0][7] = PiezaAjedrez(
      tipoPieza: TipoPieza.TORRES,
      esBlanca: false,
      nombreImagen: 'assets/images/rook-b.svg'
    );
    nuevoTablero[7][0] = PiezaAjedrez(
      tipoPieza: TipoPieza.TORRES,
      esBlanca: true,
      nombreImagen: 'assets/images/rook-w.svg'
    );
    nuevoTablero[7][7] = PiezaAjedrez(
      tipoPieza: TipoPieza.TORRES,
      esBlanca: true,
      nombreImagen: 'assets/images/rook-w.svg'
    );

    //Place knights
    nuevoTablero[0][1] = PiezaAjedrez(
      tipoPieza: TipoPieza.CABALLOS,
      esBlanca: false,
      nombreImagen: 'assets/images/knight-b.svg'
    );
    nuevoTablero[0][6] = PiezaAjedrez(
      tipoPieza: TipoPieza.CABALLOS,
      esBlanca: false,
      nombreImagen: 'assets/images/knight-b.svg'
    );
    nuevoTablero[7][1] = PiezaAjedrez(
      tipoPieza: TipoPieza.CABALLOS,
      esBlanca: true,
      nombreImagen: 'assets/images/knight-w.svg'
    );
    nuevoTablero[7][6] = PiezaAjedrez(
      tipoPieza: TipoPieza.CABALLOS,
      esBlanca: true,
      nombreImagen: 'assets/images/knight-w.svg'
    );

    //Place bishops
    nuevoTablero[0][2] = PiezaAjedrez(
      tipoPieza: TipoPieza.ALFILES,
      esBlanca: false,
      nombreImagen: 'assets/images/bishop-b.svg'
    );
    nuevoTablero[0][5] = PiezaAjedrez(
      tipoPieza: TipoPieza.ALFILES,
      esBlanca: false,
      nombreImagen: 'assets/images/bishop-b.svg'
    );
    nuevoTablero[7][2] = PiezaAjedrez(
      tipoPieza: TipoPieza.ALFILES,
      esBlanca: true,
      nombreImagen: 'assets/images/bishop-w.svg'
    );
    nuevoTablero[7][5] = PiezaAjedrez(
      tipoPieza: TipoPieza.ALFILES,
      esBlanca: true,
      nombreImagen: 'assets/images/bishop-w.svg'
    );

    //Place queens
    nuevoTablero[0][3] = PiezaAjedrez(
      tipoPieza: TipoPieza.REINAS,
      esBlanca: false,
      nombreImagen: 'assets/images/queen-b.svg'
    );
    nuevoTablero[7][4] = PiezaAjedrez(
      tipoPieza: TipoPieza.REINAS,
      esBlanca: true,
      nombreImagen: 'assets/images/queen-w.svg'
    );
    //Place kings
    nuevoTablero[0][4] = PiezaAjedrez(
      tipoPieza: TipoPieza.REYES,
      esBlanca: false,
      nombreImagen: 'assets/images/king-b.svg'
    );
    nuevoTablero[7][3] = PiezaAjedrez(
      tipoPieza: TipoPieza.REYES,
      esBlanca: true,
      nombreImagen: 'assets/images/king-w.svg'
    );

    tablero = nuevoTablero;
  } 
  
  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        Expanded(
          child: GridView.builder(
            itemCount: 8 * 8,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
            itemBuilder: (context, index) {
              int fila = index ~/ 8;
              int columna = index % 8;
              return CasillaAjedrez(
                esBlanca: esBlanca(index),
                pieza: tablero[fila][columna], 
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () => GoRouter.of(context).go('/'),
            child: const Text('Back'),
          ),
        ),
      ],
    ),
  );
}
}



