//Nombre: funciones.dart
//Descripción: Contiene las funciones necesarias para el juego de ajedrez.
import 'package:ChessHub/local_game_sesion/pieza_ajedrez.dart';
import 'package:ChessHub/constantes/constantes.dart';
import 'package:flutter/material.dart';

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

String getImagePath(String nombrePieza, bool esBlanca, TipoPieza tipoPieza) {
  String color = esBlanca ? 'w' : 'b';
  print('EL USUARIO HA ELEGIDO EL TIPO PIEZA $nombrePieza');
  switch (tipoPieza) {
    case TipoPieza.alfil:
      return 'assets/images/images_pase/pieces/$nombrePieza/${color}B.svg';
    case TipoPieza.caballo:
      return 'assets/images/images_pase/pieces/$nombrePieza/${color}N.svg';
    case TipoPieza.torre:
      return 'assets/images/images_pase/pieces/$nombrePieza/${color}R.svg';
    case TipoPieza.dama:
      return 'assets/images/images_pase/pieces/$nombrePieza/${color}Q.svg';
    case TipoPieza.rey:
      return 'assets/images/images_pase/pieces/$nombrePieza/${color}K.svg';
    case TipoPieza.peon:
      return 'assets/images/images_pase/pieces/$nombrePieza/${color}P.svg';
    default:
      throw 'No existe imagen de pieza buscada'; // Si el tipo de pieza no coincide con ninguno conocido, devuelve una imagen predeterminada
  }
}

List<Color> getColorCasilla(int elo) {
  List<Color> colorCasilla = [];
  if( elo <=1000){
    colorCasilla[0] = Color(0x8B4513); 
    colorCasilla[1] = Color(0xD2B48C);
    print("ARENA 1");
  } else if (elo <= 1200){
    colorCasilla[0] = Color(0xf5f5f5); 
    colorCasilla[1] = Color(0xB8B8B8);
    print("ARENA 2");
  } else if (elo < 1400){
    colorCasilla[0] = Color(0xFFEA70); 
    colorCasilla[1] = Color(0xF5D000);
    print("ARENA 3");
  } else if (elo < 1600){
    colorCasilla[0] = Color(0x50C878); 
    colorCasilla[1] = Color(0x38A869);
    print("ARENA 4");
  } else if (elo < 1800){
    colorCasilla[0] = Color(0xF0F0F0); 
    colorCasilla[1] = Color(0xB0E0E6);
    print("ARENA 5");
  }
  else{
    colorCasilla[0] = Color(0xF0F0F0); 
    colorCasilla[1] = Color(0xB0E0E6);
  }

  return colorCasilla;
}

 List<List<PiezaAjedrez?>> inicializarTablero(String nombre) {
    List<List<PiezaAjedrez?>> nuevoTablero =
        List.generate(8, (index) => List.generate(8, (index) => null));

    //Place pawn
    for (int i = 0; i < 8; i++) {
      nuevoTablero[1][i] = PiezaAjedrez(
          tipoPieza: TipoPieza.peon,
          esBlanca: false,
          nombreImagen: getImagePath(nombre,false,TipoPieza.peon));

      nuevoTablero[6][i] = PiezaAjedrez(
          tipoPieza: TipoPieza.peon,
          esBlanca: true,
          nombreImagen: getImagePath(nombre,true,TipoPieza.peon));
    }

    //Place rooks
    nuevoTablero[0][0] = PiezaAjedrez(
        tipoPieza: TipoPieza.torre,
        esBlanca: false,
        nombreImagen: getImagePath(nombre,false,TipoPieza.torre),
        ladoIzquierdo: true);
    nuevoTablero[0][7] = PiezaAjedrez(
        tipoPieza: TipoPieza.torre,
        esBlanca: false,
        nombreImagen: getImagePath(nombre,false,TipoPieza.torre),
        ladoIzquierdo: false);
    nuevoTablero[7][0] = PiezaAjedrez(
        tipoPieza: TipoPieza.torre,
        esBlanca: true,
        nombreImagen: getImagePath(nombre,true,TipoPieza.torre),
        ladoIzquierdo: true);
    nuevoTablero[7][7] = PiezaAjedrez(
        tipoPieza: TipoPieza.torre,
        esBlanca: true,
        nombreImagen: getImagePath(nombre,true,TipoPieza.torre),
         ladoIzquierdo: false);

    //Place knights
    nuevoTablero[0][1] = PiezaAjedrez(
        tipoPieza: TipoPieza.caballo,
        esBlanca: false,
        nombreImagen: getImagePath(nombre,false,TipoPieza.caballo));
    nuevoTablero[0][6] = PiezaAjedrez(
        tipoPieza: TipoPieza.caballo,
        esBlanca: false,
        nombreImagen: getImagePath(nombre,false,TipoPieza.caballo));
    nuevoTablero[7][1] = PiezaAjedrez(
        tipoPieza: TipoPieza.caballo,
        esBlanca: true,
        nombreImagen: getImagePath(nombre,true,TipoPieza.caballo));
    nuevoTablero[7][6] = PiezaAjedrez(
        tipoPieza: TipoPieza.caballo,
        esBlanca: true,
        nombreImagen: getImagePath(nombre,true,TipoPieza.caballo));

    //Place bishops
    nuevoTablero[0][2] = PiezaAjedrez(
        tipoPieza: TipoPieza.alfil,
        esBlanca: false,
        nombreImagen: getImagePath(nombre,false,TipoPieza.alfil));
    nuevoTablero[0][5] = PiezaAjedrez(
        tipoPieza: TipoPieza.alfil,
        esBlanca: false,
        nombreImagen: getImagePath(nombre,false,TipoPieza.alfil));
    nuevoTablero[7][2] = PiezaAjedrez(
        tipoPieza: TipoPieza.alfil,
        esBlanca: true,
        nombreImagen: getImagePath(nombre,true,TipoPieza.alfil));
    nuevoTablero[7][5] = PiezaAjedrez(
        tipoPieza: TipoPieza.alfil,
        esBlanca: true,
        nombreImagen: getImagePath(nombre,true,TipoPieza.alfil));

    //Place queens
    nuevoTablero[0][3] = PiezaAjedrez(
        tipoPieza: TipoPieza.dama,
        esBlanca: false,
        nombreImagen: getImagePath(nombre,false,TipoPieza.dama));
    nuevoTablero[7][3] = PiezaAjedrez(
        tipoPieza: TipoPieza.dama,
        esBlanca: true,
        nombreImagen: getImagePath(nombre,true,TipoPieza.dama));
    //Place kings
    nuevoTablero[0][4] = PiezaAjedrez(
        tipoPieza: TipoPieza.rey,
        esBlanca: false,
        nombreImagen: getImagePath(nombre,false,TipoPieza.rey));
    nuevoTablero[7][4] = PiezaAjedrez(
        tipoPieza: TipoPieza.rey,
        esBlanca: true,
        nombreImagen: getImagePath(nombre,true,TipoPieza.rey));

    return  nuevoTablero;
  }



