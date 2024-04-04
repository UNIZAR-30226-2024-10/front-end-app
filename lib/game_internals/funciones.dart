//Nombre: funciones.dart
//Descripción: Contiene las funciones necesarias para el juego de ajedrez.
import 'package:ChessHub/play_session/pieza_ajedrez.dart';
import 'package:ChessHub/constantes/constantes.dart';

bool esBlanca(int index) {
  int x = index ~/ 8;
  int y = index % 8;
  bool res = (x + y) % 2 == 0;

  return res;
}

String nombrePieza(PiezaAjedrez? tipoPieza) {
  String pieza = '';

  if (tipoPieza!.tipoPieza == TipoPieza.peones) {
    pieza = 'peones';
  } else if (tipoPieza.tipoPieza == TipoPieza.torres) {
    pieza = 'torres';
  } else if (tipoPieza.tipoPieza == TipoPieza.alfiles) {
    pieza = 'alfiles';
  } else if (tipoPieza.tipoPieza == TipoPieza.caballos) {
    pieza = 'caballos';
  } else if (tipoPieza.tipoPieza == TipoPieza.reyes) {
    pieza = 'reyes';
  } else if (tipoPieza.tipoPieza == TipoPieza.damas) {
    pieza = 'damas';
  }

  return pieza;
}


// Función para convertir coordenadas de la aplicación a las de la API
List<int> convertirAppToApi(int fila, int columna) {
  int xApi = columna;
  int yApi = TAMANYO_TABLERO - fila - 1;
  return [xApi, yApi];
}

// Función para convertir coordenadas de la API a las de la aplicación
List<int> convertirApiToApp(int xApi, int yApi) {
  int filaApp = TAMANYO_TABLERO - yApi - 1;
  int columnaApp = xApi;
  return [filaApp, columnaApp];
}


