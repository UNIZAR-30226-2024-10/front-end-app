//Nombre: tablero_screen.dart
//Descripción: Contiene la pantalla de juego de ajedrez.


import 'package:flutter/material.dart';
import 'package:basic/play_session/casilla_ajedrez_widget.dart';
import 'package:basic/play_session/pieza_ajedrez_widget.dart';
//import 'package:provider/provider.dart';

class TableroWidget extends StatefulWidget {
  const TableroWidget({Key? key}) : super(key: key);

  @override
  _TableroWidgetState createState() => _TableroWidgetState();
}

class _TableroWidgetState extends State<TableroWidget> {

  /*
  Widget iniciarPartida(int index, Color color) {
    if(index >= 0 && index <16){
      
    }
    else if(index >=48){
      
    }
    else{
      return CasillaAjedrez(color: color, ocupada: false, pieza: null);
    }
  }
  */
  
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
          final color = (index ~/ 8 + index % 8) % 2 == 0
              ? Colors.black
              : Colors.white;
              return CasillaAjedrez(color: color, ocupada: false, pieza: null);//iniciarPartida(index,color);
        },
      ),  
    );
  }
}