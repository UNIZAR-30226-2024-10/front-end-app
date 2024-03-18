//Nombre: tablero_screen.dart
//Descripción: Contiene la pantalla de juego de ajedrez.

import 'package:flutter/material.dart';
import 'package:basic/play_session/casilla_ajedrez_widget.dart';
import 'package:basic/constantes/constantes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para manejar la codificación y decodificación JSON
import 'dart:io'; // Para leer archivos
import 'package:flutter/services.dart';
//import 'package:basic/play_session/pieza_ajedrez_widget.dart';
//import 'package:provider/provider.dart';

class TableroWidget extends StatelessWidget {
  String respuestaBackend;
  TableroWidget({Key? key, this.respuestaBackend='',}) : super(key: key); 

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
        movimientosPosibles: respuestaBackend,
      );
    }
    else if(index >= 8 && index <=15){
      //Primera fila de piezas negras peones
      return CasillaAjedrez(
        colorCasilla: colorAsociado,
        ocupada: true,
        index: index,
        pieza:TipoPieza.PEON,
        movimientosPosibles: respuestaBackend,
      );
    }
    else if(index >= 56 && index <=63){
      //Primera fila de piezas blancas
      return CasillaAjedrez(
        colorCasilla: colorAsociado,
        ocupada: true,
        index: index,
        pieza: posicionPiezaMap[index - 56],
        movimientosPosibles: respuestaBackend,
      );
    } 
    else if(index >= 48 && index <=55){
      //Primera fila de piezas blancas peones
      return CasillaAjedrez(
        colorCasilla: colorAsociado,
        ocupada: true,
        index: index,
        pieza:TipoPieza.PEON,
        movimientosPosibles: respuestaBackend,
      );
    }
    else{
      //Casillas vacías
      return CasillaAjedrez(
        colorCasilla: colorAsociado,
        ocupada: false,
        index: index,
        movimientosPosibles: respuestaBackend,
      );
    }
  }

  //Función que envía al backend un tablero nuevo de ajedrez
  Future<void> postTableroInicial() async {
    // Lee el contenido del archivo JSON
    String jsonString = await rootBundle.loadString('assets/json/tableroInicial.json');

    // Construye la URL y realiza la solicitud POST
    Uri uri = Uri.parse('http://192.168.1.97:3001/play/');
    http.Response response = await http.post(
      uri,
      body: jsonString, // Utiliza el contenido del archivo JSON como el cuerpo de la solicitud
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json', // Especifica el tipo de contenido como JSON
      },
    );

    // Verifica el estado de la respuesta
    if (response.statusCode == 200) {
      print('La solicitud POST fue exitosa');
      print('Respuesta del servidor: ${response.body}');
    } else {
      print('Error en la solicitud POST: ${response.statusCode}');
    }
  }


  @override
  Widget build(BuildContext context) {
    //Llamada a la función para crear el tablero inicial
    postTableroInicial();
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
          return getCasilla(index);
        },
      ),
    );
  }
}

