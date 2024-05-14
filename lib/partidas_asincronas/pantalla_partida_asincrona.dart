import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:ChessHub/battle_pass/battle_pass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../log_in/log_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ChessHub/partidas_asincronas/menu_partidas_asincronas.dart';
import 'package:ChessHub/local_game_sesion/casilla_ajedrez.dart';
import 'package:ChessHub/local_game_sesion/pieza_ajedrez.dart';
import 'package:ChessHub/local_game_sesion/pieza_coronar.dart';
import 'package:ChessHub/local_game_sesion/piezaMuerta.dart';
import 'package:ChessHub/local_game_sesion/tablero_widget.dart';
import 'package:ChessHub/game_internals/funciones.dart';
import 'package:ChessHub/local_game_sesion/stats_game.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:ChessHub/win_game/fin_partida.dart';
import 'package:ChessHub/constantes/constantes.dart';
import 'package:ChessHub/game_internals/funciones.dart';


import 'package:flutter/material.dart';

class PartidaAsincrona extends StatefulWidget {
  final int idPartida;
  final int idUsuario;
  final int idRival;
  final String tablero;

  PartidaAsincrona({
    Key? key,
    required this.idPartida,
    required this.idUsuario,
    required this.idRival,
    required this.tablero,
  }) : super(key: key);

  @override
  _PartidaAsincronaState createState() => _PartidaAsincronaState();
}

class PlayerRow {
  int idUsu;
  bool esBlanca;
  int piecesCaptured;
  PlayerRow({required this.idUsu, required this.esBlanca, this.piecesCaptured = 0});

  void incrementPiecesCaptured() {
    piecesCaptured++;
  }

}



class _PartidaAsincronaState extends State<PartidaAsincrona> {
  int id = 0;
  int idUsuario = 0;
  int idRival = 0;
  String tablero = "";
  Map<String, dynamic> jsonMapTablero = {};
  Map<String, dynamic> jsonMapMovimientos = {};
  bool hayJaque = false;
  bool hayJaqueMate = false;
  bool hayTablas = false;
  late List<List<PiezaAjedrez?>> tabJuego;
  bool esTurnoBlancas = true;
  PiezaAjedrez? piezaSeleccionada;
  bool hayCoronacion = false;
  bool terminadaCoronacion = false;
  int filaSeleccionada = -1;
  int columnaSeleccionada = -1;
  List<List<int>> movimientosValidos = [];
  List<PiezaAjedrez> piezasBlancasMuertas = [];
  List<PiezaAjedrez> piezasNegrasMuertas = [];
  PlayerRow player1 = PlayerRow(idUsu: 0, esBlanca: false);
  PlayerRow player2 = PlayerRow(idUsu: 0, esBlanca: false);
  TipoPieza tipoPiezaCoronada = TipoPieza.peon;
  bool finPartida = false;
  bool posibleRendicion = false;


  @override
  void initState() {
    id = widget.idPartida;
    idUsuario = widget.idUsuario;
    idRival = widget.idRival;
    tablero = widget.tablero;
    print(tablero);
    player1 = PlayerRow(idUsu: 0, esBlanca: tablero.contains('"usuarioblancasid":"$idUsuario"'));
    player2 = PlayerRow(idUsu: 0, esBlanca: tablero.contains('"usuarioblancasid":"$idUsuario"'));
    enviarTab();
    tabJuego = inicializarTableroDesdeJson(jsonDecode(tablero) as Map<String,dynamic>, "defecto");
    super.initState();
  }

  
Future<void> postTab() async {
    Uri uri = Uri.parse('https://chesshub-api-ffvrx5sara-ew.a.run.app/users/update_cambio_partida_asincrona/$id');
    String tableroJson = jsonEncode({"tablero_actual": jsonMapTablero});
    http.Response response = await http.post(uri,body: tableroJson, headers: {HttpHeaders.contentTypeHeader: 'application/json'},);
    if(response.statusCode == 200){
      print('TABLERO POSTEADO');
    }
    else if( response.statusCode == 500){
      throw Exception('Error en la solicitud POST: ${response.statusCode}');
    }
}
  

  Future<bool> enviarTab() async {
    Uri uri = Uri.parse('https://chesshub-api-ffvrx5sara-ew.a.run.app/play/');
    http.Response response = await http.post(uri, body: tablero, headers: {HttpHeaders.contentTypeHeader: 'application/json'},);
    if(response.statusCode == 200){
      print('TABLERO ENVIADO');
      jsonMapMovimientos = jsonDecode(response.body) as Map<String, dynamic>;
      if(jsonMapMovimientos['allMovements'] != null){
        if (jsonMapMovimientos['jaque'] as bool){
          print('JAQUE');
          print(jsonMapMovimientos);
          hayJaque = true;
        }
        else{
          hayJaque = false;
        }
        print('MOVIMIENTOS VÁLIDOS\n');
        print(jsonMapMovimientos);
      }
      else if(jsonMapMovimientos['jaqueMate'] as bool){
        print('JAQUE MATE');
        hayJaqueMate = jsonMapMovimientos['jaqueMate'] as bool;
        return true;
      }
      else if(jsonMapMovimientos['tablas'] as bool){
        print('TABLAS');
        hayTablas = jsonMapMovimientos['tablas'] as bool;
        return true;
      }
      return jsonMapMovimientos['jugadaLegal'] as bool;
    }
    else{
      throw Exception('Error en la solicitud POST: ${response.statusCode}');
    }
  }
  

  List<String> obtenerMovsReyJaque(){
    print('MOVIMIENTOS REY EN JAQUE\n');
    print(jsonMapMovimientos['allMovements']['rey'][0][1]);
    List<String> movimientosValidosString = [];
    int len = (jsonMapMovimientos['allMovements']['rey'][0].length as int);
      for (int i = 1; i < len; i++) {
        String mov =
                jsonEncode(jsonMapMovimientos['allMovements']['rey'][0][i]);
            print('Anyadiendo el siguiente movimiento: ');
            print(mov);
            movimientosValidosString.add(mov);
      }
    return movimientosValidosString;
  }


  List<List<int>> obtenerMovsValidosJaque(int fila, int columna,PiezaAjedrez pieza){
    List<List<int>> movimientosValidosInt = [];
    List<int> coordenadasApi = convertirAppToApi(fila, columna);
    bool blanca = pieza.esBlanca;
    String npieza = nombrePieza(pieza);
    print('COMER O BLOQUEAR');
    print('MOVIMIENTOS BLOQUEAR');
    if(jsonMapMovimientos['allMovements']['bloquear'][0][npieza] != null){
      print('ENTRA EN BLOQUEAR');
      if(jsonMapMovimientos['allMovements']['bloquear'][0][npieza] as List != []){
        if(jsonMapMovimientos['allMovements']['bloquear'][0][npieza][0]['fromX'] == coordenadasApi[0] && jsonMapMovimientos['allMovements']['bloquear'][0][npieza][0]['fromY'] == coordenadasApi[1]){
          print('HAY MOVIMIENTOS PARA BLOQUEAR\n');
          movimientosValidosInt.add(convertirApiToApp(jsonMapMovimientos['allMovements']['bloquear'][0][npieza][0]['x'] as int, jsonMapMovimientos['allMovements']['bloquear'][0][npieza][0]['y'] as int));
        }
        else{
          print('NO HAY MOVIMIENTOS PARA BLOQUEAR\n');
        }
      }
    }
    print('MOVIMIENTOS COMER');
    if(jsonMapMovimientos['allMovements']['comer'][0][npieza] is List && 
      (jsonMapMovimientos['allMovements']['comer'][0][npieza] as List).isNotEmpty){
      print('ENTRA EN COMER');
      if((jsonMapMovimientos['allMovements']['comer'][0][npieza][0] as Map<String, dynamic>?)?.isNotEmpty ?? false) {
        if((jsonMapMovimientos['allMovements']['comer'][0][npieza][0]['fromX'] as int?) == coordenadasApi[0] &&
          (jsonMapMovimientos['allMovements']['comer'][0][npieza][0]['fromY'] as int?) == coordenadasApi[1]) {
          print('HAY MOVIMIENTOS PARA COMER\n');
          movimientosValidosInt.add(convertirApiToApp(
            (jsonMapMovimientos['allMovements']['comer'][0][npieza][0]['x'] as int),
            (jsonMapMovimientos['allMovements']['comer'][0][npieza][0]['y'] as int)
          ));
        } else {
          print('NO HAY MOVIMIENTOS PARA COMER\n');
        }
      }

    }
    return movimientosValidosInt;
  }

  List<String> obtenerMovsValidos(int fila, int columna, PiezaAjedrez pieza) {
    List<String> movimientosValidosString = [];
    // Transformar la fila y la columna en el formato de la API para que pueda ser leído
    List<int> coordenadasApi = convertirAppToApi(fila, columna);
    bool blanca = pieza.esBlanca;
    String color = blanca ? '"fromColor":"blancas"' : '"fromColor":"negras"';
    String coordenadasApiString = '{"fromX":' +
        coordenadasApi[0].toString() +
        ',"fromY":' +
        coordenadasApi[1].toString() +
        ',' +
        color +
        '}';

    print('Coordenadas a buscar: ');
    print(coordenadasApiString);

    String nPieza = nombrePieza(pieza);

    //Recorremos el mapa de movimientos válidos
    int len = jsonMapMovimientos['allMovements'][nPieza].length as int;
    for (int i = 0; i < len; i++) {
      String coor =
          jsonEncode(jsonMapMovimientos['allMovements'][nPieza][i][0]);
      if (coor == coordenadasApiString) {
        int lenMov =
            jsonMapMovimientos['allMovements'][nPieza][i].length as int;
        for (int j = 1; j < lenMov; j++) {
          String mov =
              jsonEncode(jsonMapMovimientos['allMovements'][nPieza][i][j]);
          print('Anyadiendo el siguiente movimiento: ');
          print(mov);
          movimientosValidosString.add(mov);
        }
        break;
      }
    }
    return movimientosValidosString;
  }
  


  List<int> obtenerXYDeString(String coordenadaString) {
    // Parsear el string a un mapa
    Map<String, dynamic> coordenadaMap =
        jsonDecode(coordenadaString) as Map<String, dynamic>;

    // Obtener los valores de x e y
    int x = coordenadaMap['x'] as int;
    int y = coordenadaMap['y'] as int;

    // Devolver una lista con los valores de x e y
    return [x, y];
  }


  List<List<int>> calcularMovs(List<String> movimientosValidos) {
    List<List<int>> movimientosValidosInt = [];

    //Recorrer la lista de movimientos válidos
    for (int i = 0; i < movimientosValidos.length; i++) {
      // Obtener las coordenadas de la lista de movimientos válidos
      List<int> coordenadas = obtenerXYDeString(movimientosValidos[i]);
      coordenadas = convertirApiToApp(coordenadas[0], coordenadas[1]);
      // Añadir las coordenadas a la lista de movimientos válidos
      movimientosValidosInt.add([coordenadas[0], coordenadas[1]]);
    }
    return movimientosValidosInt;
  }


  
    

  Future<void> _realizarMovimiento(int fila, int columna) async {
    if (esTurnoBlancas && piezaSeleccionada?.tipoPieza == TipoPieza.peon && fila == 0) {
      print('CORONAR PEON BLANCO\n');
      hayCoronacion = true;
      while (!terminadaCoronacion) {
        await Future.delayed(Duration(milliseconds: 1)); // Espera 1 segundo antes de verificar de nuevo
      }
      print('CORONACION TERMINADA\n');
    } else if (piezaSeleccionada?.tipoPieza == TipoPieza.peon && fila == 7) {
      hayCoronacion = true;
      while (!terminadaCoronacion) {
        await Future.delayed(Duration(milliseconds: 1)); // Espera 1 segundo antes de verificar de nuevo
      }
    }
    terminadaCoronacion = false;
    moverPieza(fila, columna);
  }

  void seleccionadaPieza (int fila, int columna){
    setState(() {
      if (piezaSeleccionada == null && tabJuego[fila][columna] != null) {
        if(tabJuego[fila][columna]!.esBlanca == esTurnoBlancas){
          piezaSeleccionada = tabJuego[fila][columna];
          filaSeleccionada = fila;
          columnaSeleccionada = columna;
        }
      } 
      else if(tabJuego[fila][columna] != null && tabJuego[fila][columna]!.esBlanca == piezaSeleccionada!.esBlanca){
        piezaSeleccionada = tabJuego[fila][columna];
        filaSeleccionada = fila;
        columnaSeleccionada = columna;
      }
      else if (piezaSeleccionada != null && movimientosValidos.any((element) => element[0] == fila && element[1] == columna)) {
        if(esTurnoBlancas && piezaSeleccionada?.tipoPieza == TipoPieza.peon && fila == 0){
          hayCoronacion = true;
        }
        else if(piezaSeleccionada?.tipoPieza == TipoPieza.peon && fila == 7){
          hayCoronacion = true;
        } 
        _realizarMovimiento(fila, columna);
      }

      print('Fila: ' + fila.toString() + ' Columna: ' + columna.toString());
      if(!hayJaque){
        movimientosValidos = calcularMovs(
          obtenerMovsValidos(fila, columna, piezaSeleccionada!));
      }
      else if (piezaSeleccionada?.tipoPieza == TipoPieza.rey){
        movimientosValidos = calcularMovs(obtenerMovsReyJaque());
      }
      else{
        movimientosValidos = obtenerMovsValidosJaque(fila, columna, piezaSeleccionada!);
      }
    });
  }

  void moverPieza(int filaNueva, int columnaNueva) async {
    List<int> coordenadasAntiguasApi =
        convertirAppToApi(filaSeleccionada, columnaSeleccionada);
    List<int> coordenadasNuevasApi = convertirAppToApi(filaNueva, columnaNueva);

    print('TABLERO ANTES DE MOVER LA PIEZA\n');
    print(tablero);

    Map<String, dynamic> jsonMapTableroAntiguo =
        jsonDecode(tablero) as Map<String, dynamic>;

    if(tabJuego[filaNueva][columnaNueva] != null){
      if(tabJuego[filaNueva][columnaNueva]!.esBlanca){
        piezasBlancasMuertas.add(tabJuego[filaNueva][columnaNueva]!);
        setState(() {
          player1.incrementPiecesCaptured();
        });
      }
      else{
        piezasNegrasMuertas.add(tabJuego[filaNueva][columnaNueva]!);
        setState(() {
          player2.incrementPiecesCaptured();
        });
      }
      //si se trata de una muerte, debemos eliminar la pieza del tablero
      jsonMapTablero.forEach((tipoPieza, listaPiezas) {
        if (listaPiezas is List) {
          // Filtra la lista de piezas para eliminar la pieza con las coordenadas dadas
          listaPiezas.removeWhere((pieza) => pieza['x'] == coordenadasNuevasApi[0] && pieza['y'] == coordenadasNuevasApi[1]);
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Movimiento realizado correctamente')));
      Navigator.push(context, MaterialPageRoute(builder: (context) => PartidasAsincronas(id: idUsuario, modoJuego: Modos.ASINCRONO)));
    }

    //Coronación
    if(hayCoronacion && esTurnoBlancas){
      String imagen = obtenerRutaImagen(tipoPiezaCoronada,esTurnoBlancas);
      //Coronamos peon blanco
      jsonMapTablero.forEach((tipoPieza, listaPiezas) {
        if (listaPiezas is List) {
          // Filtra la lista de piezas para eliminar la pieza con las coordenadas dadas
          listaPiezas.removeWhere((pieza) => pieza['x'] == coordenadasNuevasApi[0] && pieza['y'] == coordenadasNuevasApi[1]);
        }
      });
      String color = "blancas";
      jsonMapTablero[nombrePiezaTipo(tipoPiezaCoronada)].add({'x': coordenadasNuevasApi[0], 'y': coordenadasNuevasApi[1], 'color': color});
      jsonMapTablero['piezaCoronada'] = nombrePiezaTipo(tipoPiezaCoronada);
      piezaSeleccionada = piezaSeleccionada?.cambiarTipoPieza(tipoPiezaCoronada,imagen);
    }
    else if(hayCoronacion && !esTurnoBlancas){
      String imagen = obtenerRutaImagen(tipoPiezaCoronada,esTurnoBlancas);
      //Coronamos peon negro
      jsonMapTablero.forEach((tipoPieza, listaPiezas) {
        if (listaPiezas is List) {
          // Filtra la lista de piezas para eliminar la pieza con las coordenadas dadas
          listaPiezas.removeWhere((pieza) => pieza['x'] == coordenadasNuevasApi[0] && pieza['y'] == coordenadasNuevasApi[1]);
        }
      });

      String color = "negras";
      jsonMapTablero[nombrePiezaTipo(tipoPiezaCoronada)].add({'x': coordenadasNuevasApi[0], 'y': coordenadasNuevasApi[1], 'color': color});
      jsonMapTablero['piezaCoronada'] = nombrePiezaTipo(tipoPiezaCoronada);
      piezaSeleccionada = piezaSeleccionada?.cambiarTipoPieza(tipoPiezaCoronada,imagen);
    }

    if (esTurnoBlancas) {
      jsonMapTablero['turno'] = 'negras';
      esTurnoBlancas = false;
    } else {
      jsonMapTablero['turno'] = 'blancas';
      esTurnoBlancas = true;
    }

    //Marcamos que la pieza torre ha sido movida para que el backend no permita enrocar
    if(piezaSeleccionada!.tipoPieza == TipoPieza.torre){
      if(piezaSeleccionada!.esBlanca && piezaSeleccionada!.ladoIzquierdo){
        jsonMapTablero['ha_movido_torre_blanca_izqda'] = true;
      }
      else if(piezaSeleccionada!.esBlanca){
        jsonMapTablero['ha_movido_torre_blanca_dcha'] = true;
      }
      else if(piezaSeleccionada!.ladoIzquierdo){
        jsonMapTablero['ha_movido_torre_negra_izqda'] = true;
      }
      else{
        jsonMapTablero['ha_movido_torre_negra_dcha'] = true;
      }
    }

    //Revisamos si hay enroque y si existe hacemos los cambios correspondientes
    if(piezaSeleccionada!.tipoPieza == TipoPieza.rey && (jsonMapTablero['ha_movido_rey_blanco'] == false && 
      (jsonMapTablero['ha_movido_torre_blanca_izqda'] == false || jsonMapTablero['ha_movido_torre_blanca_dcha'] == false)
     || jsonMapTablero['ha_movido_rey_negro'] == false &&
      (jsonMapTablero['ha_movido_torre_negra_izqda'] == false || jsonMapTablero['ha_movido_torre_negra_dcha'] == false)) 
      && hayEnroque(coordenadasAntiguasApi, coordenadasNuevasApi)){

      int filaNueva = 0, columnaNueva = 0, filaAntigua = 0, columnaAntigua = 0;
      bool hayEnroque = false;

      List<bool> torreEnrocar = torreEnroque(coordenadasNuevasApi);
        
      if(jsonMapTablero['ha_movido_rey_blanco'] == false){
        //Si se trata de un enroque con la torre blanca izquierda
        if(torreEnrocar[0]){
          print("ENROQUE BLANCA IZQUIERDA");
          filaNueva = filaSeleccionada;
          columnaNueva = columnaSeleccionada - 1;
          filaAntigua = 7;
          columnaAntigua = 0;

          jsonMapTablero['ha_movido_torre_blanca_izqda'] = true;
          hayEnroque = true;
        }
        else if(torreEnrocar[1]){
          print("ENROQUE BLANCA DERECHA");
          filaNueva = filaSeleccionada;
          columnaNueva = columnaSeleccionada + 1;
          filaAntigua = 7;
          columnaAntigua = 7;

          jsonMapTablero['ha_movido_torre_blanca_dcha'] = true;
          hayEnroque = true;
        }
      }
      else if(jsonMapTablero['ha_movido_rey_negro'] == false){
        if(torreEnrocar[3]){
          print("ENROQUE NEGRA IZQUIERDA");
          filaNueva = filaSeleccionada;
          columnaNueva = columnaSeleccionada + 1;
          filaAntigua = 0;
          columnaAntigua = 7;

          jsonMapTablero['ha_movido_torre_negra_izqda'] = true;
          hayEnroque = true;
        }
        else if(torreEnrocar[2]){
          print("ENROQUE NEGRA DERECHA");
          filaNueva = filaSeleccionada;
          columnaNueva = columnaSeleccionada - 1;
          filaAntigua = 0;
          columnaAntigua = 0;

          jsonMapTablero['ha_movido_torre_negra_dcha'] = true;
          hayEnroque = true;
        }
      }

      if(hayEnroque){

        tabJuego[filaNueva][columnaNueva] = tabJuego[filaAntigua][columnaAntigua];
        tabJuego[filaAntigua][columnaAntigua] = null;

        List<int> auxAntiguasApi = convertirAppToApi(filaAntigua, columnaAntigua);
        List<int> auxNuevasApi = convertirAppToApi(filaNueva, columnaNueva);
        //Esto se puede cambiar con asignación de variables pedazo de vago
        jsonMapTablero.forEach((tipoPieza, listaPiezas) {
        if (listaPiezas is List) {
          // Itera sobre cada pieza en la lista
            for (var pieza in listaPiezas) {
              // Verifica si las coordenadas coinciden con las coordenadas antiguas
              if (pieza['x'] == auxAntiguasApi[0] &&
                  pieza['y'] == auxAntiguasApi[1]) {
                // Modifica las coordenadas con las nuevas coordenadas
                pieza['x'] = auxNuevasApi[0];
                pieza['y'] = auxNuevasApi[1];
                break;
              }
            }
          }
        });
      }
    }

    //Marcamos que la pieza rey ha sido movida para que el backend no permita enrocar
    if(piezaSeleccionada!.tipoPieza == TipoPieza.rey){
      if(piezaSeleccionada!.esBlanca){
        jsonMapTablero['ha_movido_rey_blanco'] = true;
      }
      else{
        jsonMapTablero['ha_movido_rey_negro'] = true;
      }
    }

    //Esto igual, se puede cambiar con asignación de variables

    if (!hayCoronacion) {
      jsonMapTablero.forEach((tipoPieza, listaPiezas) {
        if (listaPiezas is List) {
          // Itera sobre cada pieza en la lista
          for (var pieza in listaPiezas) {
            // Verifica si las coordenadas coinciden con las coordenadas antiguas
            if (pieza['x'] == coordenadasAntiguasApi[0] &&
                pieza['y'] == coordenadasAntiguasApi[1]) {
              // Modifica las coordenadas con las nuevas coordenadas
              pieza['x'] = coordenadasNuevasApi[0];
              pieza['y'] = coordenadasNuevasApi[1];
              break;
            }
          }
        }
      });
    }
    hayCoronacion = false;

    String jsonString = jsonEncode(jsonMapTablero);

    //Enviamos el tablero con la posible jugada
    bool jugadaValida = await enviarTab();

    print('TABLERO DESPUÉS DE MOVER LA PIEZA\n');
    print(jsonString);

    if (!jugadaValida) {
      print('Jugada no valida');
      //devolvemos el string a su estado original
      jsonString = jsonEncode(jsonMapTableroAntiguo);
      jsonMapTablero = jsonMapTableroAntiguo;
      //PONER VARIABLES DE CONTROL A FALSE
      hayJaque = false;
      hayJaqueMate = false;
      hayTablas = false;
      return;
    }


    print('Jugada valida');
    tabJuego[filaNueva][columnaNueva] = piezaSeleccionada;
    tabJuego[filaSeleccionada][columnaSeleccionada] = null;

    if(hayJaqueMate || hayTablas){
      finPartida = true;
    }


    //limpiamos la selección
    setState(() {
      piezaSeleccionada = null;
      filaSeleccionada = -1;
      columnaSeleccionada = -1;
      movimientosValidos = [];
    });
  }


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      color: Color.fromRGBO(49, 45, 45, 1),
      child: Column(
        children: [
          // MODO DE JUEGO
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'PARTIDA ASÍNCRONA',
              style: GoogleFonts.play(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          // PlayRow de Jugador 1
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.0),
            child: Text(
              '$idUsuario',
              style: GoogleFonts.play(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          // TABLERO
          Expanded(
            flex: 4, // Ajusta este valor según tus necesidades
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: finPartida && (hayJaqueMate || hayTablas )
                  ? FinPartida(esColorBlanca: !esTurnoBlancas, esJaqueMate: hayJaqueMate, esAhogado: hayTablas)
                  : GridView.builder(
                      itemCount: 8 * 8,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 8,
                      ),
                      itemBuilder: (context, index) {
                        int fila = index ~/ 8;
                        int columna = index % 8;

                        bool seleccionada = filaSeleccionada == fila && columnaSeleccionada == columna;

                        bool esValido = movimientosValidos.any((position) => position[0] == fila && position[1] == columna);

                        return CasillaAjedrez(
                          seleccionada: seleccionada,
                          esBlanca: esBlanca(index),
                          pieza: tabJuego[fila][columna],
                          esValido: esValido,
                          onTap: () => seleccionadaPieza(fila, columna),
                          colorCasillaBlanca: Color(0xFFADF597),
                          colorCasillaNegra: Color(0XFF2E960F),
                        );
                      },
                    ),
            ),
          ),
          //SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          // PlayRow de Jugador 2
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.0),
            child: Text(
              '$idRival',
              style: GoogleFonts.play(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.07),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Se muestra si la partida ha finalizado
              finPartida
                  ? Text(
                      'PARTIDA FINALIZADA',
                      style: GoogleFonts.play(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : SizedBox(), // Espacio vacío si la partida no ha finalizado
              // Se muestra si es posible rendirse
              !finPartida && posibleRendicion
                  ? Container(
                      // Contenedor con pregunta y botones de sí y no
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              '¿Estás seguro de que quieres rendirte?',
                              style: GoogleFonts.play(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  GoRouter.of(context).go('/');
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.red,
                                  ),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Sí',
                                  style: GoogleFonts.play(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    posibleRendicion = false; // Cambia el estado de posibleRendicion
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.grey,
                                  ),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'No',
                                  style: GoogleFonts.play(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : ElevatedButton(
                      // Botón de rendirse
                      onPressed: () {
                        // Realiza la lógica para rendirse o continuar la partida
                        setState(() {
                          posibleRendicion = true; // Cambia el estado de posibleRendicion
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(255, 136, 0, 1),
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      child: Text(
                        'Rendirse',
                        style: GoogleFonts.play(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                if (hayCoronacion)
                      Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Acción a realizar cuando se toca la pieza dama
                                    tipoPiezaCoronada = TipoPieza.dama;
                                    terminadaCoronacion = true;
                                  },
                                  child: PiezaCoronar(esBlanca: esTurnoBlancas, tipoPieza: TipoPieza.dama),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Acción a realizar cuando se toca la pieza alfil
                                    tipoPiezaCoronada = TipoPieza.alfil;
                                    terminadaCoronacion = true;
                                  },
                                  child: PiezaCoronar(esBlanca: esTurnoBlancas, tipoPieza: TipoPieza.alfil),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Acción a realizar cuando se toca la pieza caballo
                                    tipoPiezaCoronada = TipoPieza.caballo;
                                    terminadaCoronacion = true;
                                  },
                                  child: PiezaCoronar(esBlanca: esTurnoBlancas, tipoPieza: TipoPieza.caballo),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Acción a realizar cuando se toca la pieza torre
                                    tipoPiezaCoronada = TipoPieza.torre;
                                    terminadaCoronacion = true;
                                  },
                                  child: PiezaCoronar(esBlanca: esTurnoBlancas, tipoPieza: TipoPieza.torre),
                                ),
                              ],
                            ),
                        ],
                      ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.10),
            ],
          ),
        ],
      ),
    ),
  );
}
}
