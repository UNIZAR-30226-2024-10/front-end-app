//Nombre: tablero_screen.dart
//Descripción: Contiene la pantalla de juego de ajedrez.

import 'package:flutter/material.dart';
import 'package:basic/play_session/casilla_ajedrez_widget.dart';
import 'package:basic/assets/constantes/constantes.dart';
import 'package:flutter/services.dart';
//import 'package:basic/play_session/pieza_ajedrez_widget.dart';
//import 'package:provider/provider.dart';

class TableroWidget extends StatelessWidget {
  const TableroWidget({Key? key}) : super(key: key); 

  //Función que devuelve un objeto CasillaAjedrez en el que correspone a la posición de la pieza
  CasillaAjedrez? getCasilla(int index) {
    Color colorAsociado = (index ~/ 8 + index % 8) % 2 == 0 ? const Color.fromARGB(255, 60, 114, 62) : Colors.white;
    if (index >= 0 && index <= 7) {
      //Primera fila de piezas negras
      return CasillaAjedrez(
        colorCasilla: colorAsociado,
        ocupada: true,
        index: index,
        pieza: posicionPiezaMap[index],
      );
    }
    else if(index >= 8 && index <=15){
      //Primera fila de piezas negras peones
      return CasillaAjedrez(
        colorCasilla: colorAsociado,
        ocupada: true,
        index: index,
        pieza:TipoPieza.peon,
      );
    }
    else if(index >= 56 && index <=63){
      //Primera fila de piezas blancas
      return CasillaAjedrez(
        colorCasilla: colorAsociado,
        ocupada: true,
        index: index,
        pieza: posicionPiezaMap[index - 56],
      );
    } 
    else if(index >= 48 && index <=55){
      //Primera fila de piezas blancas peones
      return CasillaAjedrez(
        colorCasilla: colorAsociado,
        ocupada: true,
        index: index,
        pieza:TipoPieza.peon,
      );
    }
    else{
      //Casillas vacías
      return CasillaAjedrez(
        colorCasilla: colorAsociado,
        ocupada: false,
        index: index,
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 320,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
        ),
        itemBuilder: (context, index) {
          final color =
              (index ~/ 8 + index % 8) % 2 == 0 ? Colors.black : Colors.white;
          return getCasilla(index);
        },
      ),
    );
  }
}

