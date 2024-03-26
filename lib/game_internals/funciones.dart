//Nombre: funciones.dart
//Descripción: Contiene las funciones necesarias para el juego de ajedrez.
import 'package:ChessHub/play_session/pieza_ajedrez.dart';

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
  } else if (tipoPieza.tipoPieza == TipoPieza.reinas) {
    pieza = 'reinas';
  }

  return pieza;
}
