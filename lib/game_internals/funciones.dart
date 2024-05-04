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

  if (tipoPieza!.tipoPieza == TipoPieza.peon) {
    pieza = 'peon';
  } else if (tipoPieza.tipoPieza == TipoPieza.torre) {
    pieza = 'torre';
  } else if (tipoPieza.tipoPieza == TipoPieza.alfil) {
    pieza = 'alfil';
  } else if (tipoPieza.tipoPieza == TipoPieza.caballo) {
    pieza = 'caballo';
  } else if (tipoPieza.tipoPieza == TipoPieza.rey) {
    pieza = 'rey';
  } else if (tipoPieza.tipoPieza == TipoPieza.dama) {
    pieza = 'dama';
  }

  return pieza;
}

String nombrePiezaTipo(TipoPieza tipoPieza){
  String pieza = '';

  if (tipoPieza == TipoPieza.peon) {
    pieza = 'peon';
  } else if (tipoPieza == TipoPieza.torre) {
    pieza = 'torre';
  } else if (tipoPieza == TipoPieza.alfil) {
    pieza = 'alfil';
  } else if (tipoPieza == TipoPieza.caballo) {
    pieza = 'caballo';
  } else if (tipoPieza == TipoPieza.rey) {
    pieza = 'rey';
  } else if (tipoPieza == TipoPieza.dama) {
    pieza = 'dama';
  }

  return pieza;
}

String obtenerRutaImagen(TipoPieza tipoPieza, bool esBlanca) {
  String colorPrefix = esBlanca ? 'w' : 'b';
  String pieceName;
  
  switch (tipoPieza) {
    case TipoPieza.peon:
      pieceName = 'pawn';
      break;
    case TipoPieza.torre:
      pieceName = 'rook';
      break;
    case TipoPieza.caballo:
      pieceName = 'knight';
      break;
    case TipoPieza.alfil:
      pieceName = 'bishop';
      break;
    case TipoPieza.dama:
      pieceName = 'queen';
      break;
    case TipoPieza.rey:
      pieceName = 'king';
      break;
  }
  
  return 'assets/images/$pieceName-$colorPrefix.svg';
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

//Función para determinar si un enroque se ha realizado
bool hayEnroque(List<int> coordenadasAntiguasApi, List<int> coordenadasNuevasApi){
  return (coordenadasNuevasApi[0] - coordenadasAntiguasApi[0]).abs() == 2;
}

List<bool> torreEnroque(List<int> coordenadasNuevasApi){
  List<bool> res = [false, false, false, false];
  //Enroque blanco blanco izquierda
  if(coordenadasNuevasApi[0] == 2 && coordenadasNuevasApi[1] == 0){
    res[0] = true;
  } 
  //Enroque blanco blanco derecha
  else if(coordenadasNuevasApi[0] == 6 && coordenadasNuevasApi[1] == 0){
    res[1] = true;
  }
  //Enroque negro derecha
  else if(coordenadasNuevasApi[0] == 2 && coordenadasNuevasApi[1] == 7){
    res[2] = true;
  } 
  //Enroque negro izquierda
  else if(coordenadasNuevasApi[0] == 6 && coordenadasNuevasApi[1] == 7){
    res[3] = true;
  }
  return res;
}


