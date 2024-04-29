//Nombre: tablero_screen.dart
//Descripción: Contiene la pantalla de juego de ajedrez.

//import 'dart:ffi';

import 'package:ChessHub/play_session/pieza_ajedrez.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ChessHub/play_session/casilla_ajedrez.dart';
import 'package:ChessHub/constantes/constantes.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para manejar la codificación y decodificación JSON
import 'dart:io'; // Para leer archivos
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ChessHub/play_session/piezaMuerta.dart';
import 'package:ChessHub/game_internals/funciones.dart';
import 'package:ChessHub/play_session/stats_game.dart';
import 'package:ChessHub/win_game/jaque_mate.dart';
import 'dart:async';
//import 'package:ChessHub/play_session/pieza_ajedrez_widget.dart';
//import 'package:provider/provider.dart';

class TableroAjedrez extends StatefulWidget {
  
  final Modos modoJuego;
  const TableroAjedrez({Key? key, required this.modoJuego}) : super(key: key);

  @override
  State<TableroAjedrez> createState() => _TableroAjedrezState();
}

class _TableroAjedrezState extends State<TableroAjedrez> {

  //VARIABLES

  late List<List<PiezaAjedrez?>> tablero;

  PiezaAjedrez? piezaSeleccionada;

  int filaSeleccionada = -1;

  int columnaSeleccionada = -1;

  String jsonString = '';

  List<List<int>> movimientosValidos = [];

  Map<String, dynamic> jsonMapTablero = {};

  Map<String, dynamic> jsonMapMovimientos = {};

  List<PiezaAjedrez> piezasBlancasMuertas = [];

  List<PiezaAjedrez> piezasNegrasMuertas = [];

  Duration duracionPartida = Duration(minutes: 10);

  PlayerRow player1 = PlayerRow(playerName: 'Jugador 1', esBlanca: false);

  PlayerRow player2 = PlayerRow(playerName: 'Jugador 2', esBlanca: true);

  bool esTurnoBlancas = true;

  bool hayJaque = false;

  bool hayJaqueMate = false;

  bool finPartida = false;

  String modoDeJuego = '';

  bool posibleRendicion = false;

  //MÉTODOS
  @override
  //INICIAR EL ESTADO
  void initState() {
    super.initState();
    _tratamientoMododeJuego();
    _cargarTableroInicial();
    _inicializarTablero();
  }

  void _tratamientoMododeJuego() async{
    if(widget.modoJuego == Modos.BLITZ){
      modoDeJuego = 'BLITZ';
      player1.changeTimer(Duration(minutes: 3));
      player2.changeTimer(Duration(minutes: 3));
    }
    else if(widget.modoJuego == Modos.RAPID){
      modoDeJuego = 'RAPID';
      player1.changeTimer(Duration(minutes: 10));
      player2.changeTimer(Duration(minutes: 10));
    }
    else{
      modoDeJuego = 'BULLET';
      player1.changeTimer(Duration(minutes: 1));
      player2.changeTimer(Duration(minutes: 1));
    }
  }

  //CARGAR TABLERO INICIAL
  void _cargarTableroInicial() async {
    // Cargar el tablero inicial
    jsonString = await rootBundle.loadString('assets/json/tableroInicial.json');
    jsonMapTablero = jsonDecode(jsonString) as Map<String, dynamic>;
    print('TABLERO INICIAL\n');
    print(jsonMapTablero);
    _postTablero();
  }

  //ENVIAR TABLERO A BACKEND
  Future<bool> _postTablero() async {
    // Construye la URL y realiza la solicitud POST
    //http://192.168.1.97:3001/play/
    Uri uri = Uri.parse('http://192.168.1.97:3001/play/');
    http.Response response = await http.post(
      uri,
      body:
          jsonString, // Utiliza el contenido del archivo JSON como el cuerpo de la solicitud
      headers: {
        HttpHeaders.contentTypeHeader:
            'application/json', // Especifica el tipo de contenido como JSON
      },
    );

    // Verifica el estado de la respuesta
    if (response.statusCode == 200) {
      print('ENVIO DE TABLERO A BACKEND EXITOSO\n');
      //Decodifica la respuesta JSON
      jsonMapMovimientos = jsonDecode(response.body) as Map<String, dynamic>;
      if(jsonMapMovimientos['allMovements'] != null){
        print(jsonMapMovimientos['allMovements']);
      }

      //Comprobamos si hay jaque mate
      if(jsonMapMovimientos['Jaque mate'] != null){
        print('JAQUE MATE\n');
        hayJaqueMate = jsonMapMovimientos['Jaque mate'] as bool;
        return true;
      }
      
      //Finalmente devolvemos si la jugada es legal o no
      return jsonMapMovimientos['jugadaLegal'] as bool;
    } else {
      throw Exception('Error en la solicitud POST: ${response.statusCode}');
    }
    //prueba, borrar en la entrega final
    /*
    print('PRUEBA DE CORRECTO LISTADO DE MOVIMIENTOS VÁLIDOS\n');
    //Recorremos el mapa de movimientos válidos
    List<String> movimientosValidos = obtenerMovimientosValidos(1, 0, PiezaAjedrez(tipoPieza: TipoPieza.peon, esBlanca: true, nombreImagen: 'assets/images/pawn-w.svg'));
    List<List<int>> movimientosValidosInt = calcularMovimientos(movimientosValidos);

    //Mostramos el resultado
    for (int i = 0; i < movimientosValidosInt.length; i++) {
      List<int> sublista = movimientosValidosInt[i];
    // Recorrer la sublista
      for (int j = 0; j < sublista.length; j++) {
        print(sublista[j]);
      }
    }
    */

    //print('PRUEBA DE CORRECTO LISTADO DE MOVIMIENTOS VÁLIDOS\n');
    //Recorremos el mapa de movimientos válidos
    //print(jsonMapMovimientos['allMovements']['peon'][0][1]);
    //List<List<int>> movimientosValidos = calcularMovimientosValidos(0, 2, PiezaAjedrez(tipoPieza: TipoPieza.peon, esBlanca: true, nombreImagen: 'assets/images/pawn-w.svg'));
  }
  
  //CALCULAR MOVIMIENTOS POSIBLES
  List<String> obtenerMovimientosValidos(
      int fila, int columna, PiezaAjedrez pieza) {
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
  
  //OBTENER COORDENADAS DE STRING
  List<int> obtenerXYFromString(String coordenadaString) {
    // Parsear el string a un mapa
    Map<String, dynamic> coordenadaMap =
        jsonDecode(coordenadaString) as Map<String, dynamic>;

    // Obtener los valores de x e y
    int x = coordenadaMap['x'] as int;
    int y = coordenadaMap['y'] as int;

    // Devolver una lista con los valores de x e y
    return [x, y];
  }
  
  //CALCULAR MOVIMIENTOS DE PIEZA SELECCIONADA
  List<List<int>> calcularMovimientos(List<String> movimientosValidos) {
    List<List<int>> movimientosValidosInt = [];

    //Recorrer la lista de movimientos válidos
    for (int i = 0; i < movimientosValidos.length; i++) {
      // Obtener las coordenadas de la lista de movimientos válidos
      List<int> coordenadas = obtenerXYFromString(movimientosValidos[i]);
      coordenadas = convertirApiToApp(coordenadas[0], coordenadas[1]);
      // Añadir las coordenadas a la lista de movimientos válidos
      movimientosValidosInt.add([coordenadas[0], coordenadas[1]]);
    }
    return movimientosValidosInt;
  }
  
  //INICIALIZAR TABLERO
  void _inicializarTablero() {
    List<List<PiezaAjedrez?>> nuevoTablero =
        List.generate(8, (index) => List.generate(8, (index) => null));

    //Place pawn
    for (int i = 0; i < 8; i++) {
      nuevoTablero[1][i] = PiezaAjedrez(
          tipoPieza: TipoPieza.peon,
          esBlanca: false,
          nombreImagen: 'assets/images/pawn-b.svg');

      nuevoTablero[6][i] = PiezaAjedrez(
          tipoPieza: TipoPieza.peon,
          esBlanca: true,
          nombreImagen: 'assets/images/pawn-w.svg');
    }

    //Place rooks
    nuevoTablero[0][0] = PiezaAjedrez(
        tipoPieza: TipoPieza.torre,
        esBlanca: false,
        nombreImagen: 'assets/images/rook-b.svg');
    nuevoTablero[0][7] = PiezaAjedrez(
        tipoPieza: TipoPieza.torre,
        esBlanca: false,
        nombreImagen: 'assets/images/rook-b.svg',
        ladoIzquierdo: true);
    nuevoTablero[7][0] = PiezaAjedrez(
        tipoPieza: TipoPieza.torre,
        esBlanca: true,
        nombreImagen: 'assets/images/rook-w.svg',
        ladoIzquierdo: true);
    nuevoTablero[7][7] = PiezaAjedrez(
        tipoPieza: TipoPieza.torre,
        esBlanca: true,
        nombreImagen: 'assets/images/rook-w.svg');

    //Place knights
    nuevoTablero[0][1] = PiezaAjedrez(
        tipoPieza: TipoPieza.caballo,
        esBlanca: false,
        nombreImagen: 'assets/images/knight-b.svg');
    nuevoTablero[0][6] = PiezaAjedrez(
        tipoPieza: TipoPieza.caballo,
        esBlanca: false,
        nombreImagen: 'assets/images/knight-b.svg');
    nuevoTablero[7][1] = PiezaAjedrez(
        tipoPieza: TipoPieza.caballo,
        esBlanca: true,
        nombreImagen: 'assets/images/knight-w.svg');
    nuevoTablero[7][6] = PiezaAjedrez(
        tipoPieza: TipoPieza.caballo,
        esBlanca: true,
        nombreImagen: 'assets/images/knight-w.svg');

    //Place bishops
    nuevoTablero[0][2] = PiezaAjedrez(
        tipoPieza: TipoPieza.alfil,
        esBlanca: false,
        nombreImagen: 'assets/images/bishop-b.svg');
    nuevoTablero[0][5] = PiezaAjedrez(
        tipoPieza: TipoPieza.alfil,
        esBlanca: false,
        nombreImagen: 'assets/images/bishop-b.svg');
    nuevoTablero[7][2] = PiezaAjedrez(
        tipoPieza: TipoPieza.alfil,
        esBlanca: true,
        nombreImagen: 'assets/images/bishop-w.svg');
    nuevoTablero[7][5] = PiezaAjedrez(
        tipoPieza: TipoPieza.alfil,
        esBlanca: true,
        nombreImagen: 'assets/images/bishop-w.svg');

    //Place queens
    nuevoTablero[0][3] = PiezaAjedrez(
        tipoPieza: TipoPieza.dama,
        esBlanca: false,
        nombreImagen: 'assets/images/queen-b.svg');
    nuevoTablero[7][3] = PiezaAjedrez(
        tipoPieza: TipoPieza.dama,
        esBlanca: true,
        nombreImagen: 'assets/images/queen-w.svg');
    //Place kings
    nuevoTablero[0][4] = PiezaAjedrez(
        tipoPieza: TipoPieza.rey,
        esBlanca: false,
        nombreImagen: 'assets/images/king-b.svg');
    nuevoTablero[7][4] = PiezaAjedrez(
        tipoPieza: TipoPieza.rey,
        esBlanca: true,
        nombreImagen: 'assets/images/king-w.svg');

    tablero = nuevoTablero;
  }
  
  //SELECCIONAR PIEZA
  void seleccionadaPieza(int fila, int columna) {
    setState(() {
      if (piezaSeleccionada == null && tablero[fila][columna] != null) {
        if(tablero[fila][columna]!.esBlanca == esTurnoBlancas){
          piezaSeleccionada = tablero[fila][columna];
          filaSeleccionada = fila;
          columnaSeleccionada = columna;
        }
      } 
      else if(tablero[fila][columna] != null && tablero[fila][columna]!.esBlanca == piezaSeleccionada!.esBlanca){
        piezaSeleccionada = tablero[fila][columna];
        filaSeleccionada = fila;
        columnaSeleccionada = columna;
      }
      else if (piezaSeleccionada != null &&
          movimientosValidos
              .any((element) => element[0] == fila && element[1] == columna)) {
        moverPieza(fila, columna);
      }

      print('Fila: ' + fila.toString() + ' Columna: ' + columna.toString());
      movimientosValidos = calcularMovimientos(
          obtenerMovimientosValidos(fila, columna, piezaSeleccionada!));
    });
  }
  
  //MOVER PIEZA
  void moverPieza(int filaNueva, int columnaNueva) async {
    List<int> coordenadasAntiguasApi =
        convertirAppToApi(filaSeleccionada, columnaSeleccionada);
    List<int> coordenadasNuevasApi = convertirAppToApi(filaNueva, columnaNueva);

    print('TABLERO ANTES DE MOVER LA PIEZA\n');
    print(jsonString);

    Map<String, dynamic> jsonMapTableroAntiguo =
        jsonDecode(jsonString) as Map<String, dynamic>;

    if(tablero[filaNueva][columnaNueva] != null){
      if(tablero[filaNueva][columnaNueva]!.esBlanca){
        piezasBlancasMuertas.add(tablero[filaNueva][columnaNueva]!);
        player1.incrementPiecesCaptured();
      }
      else{
        piezasNegrasMuertas.add(tablero[filaNueva][columnaNueva]!);
        player2.incrementPiecesCaptured();
      }
      //si se trata de una muerte, debemos eliminar la pieza del tablero
      jsonMapTablero.forEach((tipoPieza, listaPiezas) {
        if (listaPiezas is List) {
          // Filtra la lista de piezas para eliminar la pieza con las coordenadas dadas
          listaPiezas.removeWhere((pieza) => pieza['x'] == coordenadasNuevasApi[0] && pieza['y'] == coordenadasNuevasApi[1]);
        }
      });
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

        tablero[filaNueva][columnaNueva] = tablero[filaAntigua][columnaAntigua];
        tablero[filaAntigua][columnaAntigua] = null;

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
    
    jsonString = jsonEncode(jsonMapTablero);

    //Enviamos el tablero con la posible jugada
    bool jugadaValida = await _postTablero();

    print('TABLERO DESPUÉS DE MOVER LA PIEZA\n');
    print(jsonString);

    if (!jugadaValida) {
      print('Jugada no valida');
      //devolvemos el string a su estado original
      jsonString = jsonEncode(jsonMapTableroAntiguo);
      jsonMapTablero = jsonMapTableroAntiguo;
      return;
    }

    //PARAR CRONOMETRO Y CAMBIAR DE TURNO
    if(jsonMapTableroAntiguo['turno'] == 'blancas'){
      player2.pauseTimer();
      player1.resumeTimer();
    }
    else{
      player2.resumeTimer();
      player1.pauseTimer();
    }

    print('Jugada valida');
    tablero[filaNueva][columnaNueva] = piezaSeleccionada;
    tablero[filaSeleccionada][columnaSeleccionada] = null;

    if(hayJaqueMate){
      finPartida = true;
      player1.pauseTimer();
      player2.pauseTimer();
    }
    //limpiamos la selección
    setState(() {
      piezaSeleccionada = null;
      filaSeleccionada = -1;
      columnaSeleccionada = -1;
      movimientosValidos = [];
    });
  }

  //CONSTRUIR WIDGET
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color : Color.fromRGBO(49, 45, 45, 1),
        child:
         Column(
          children: [
            //MODO DE JUEGO
            Flexible(
              child: Container(
                margin: EdgeInsets.only(top: 10), // Añade margen en la parte superior
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10), // Redondea los bordes
                ),
                height: 50,
                width: 170,
                 child: Center(
                    child: Text(
                      modoDeJuego,
                      style: GoogleFonts.play(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ),
              ),
            ),
            SizedBox(height: 40),
            //PIEZAS BLANCAS MUERTAS
            /*
            Expanded(
              child: GridView.builder(
                itemCount: piezasBlancasMuertas.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8),
                itemBuilder: (context, index) => PiezaMuerta(
                  pathImagen: piezasBlancasMuertas[index].nombreImagen,
                  esBlanca: true,
                ),
              ),
            ),
            */
             Column(
              children: [
                Padding(padding: 
                  EdgeInsets.symmetric(horizontal: 7.0),
                  child:player1,
                ),
              ]
            ),
            SizedBox(height: 20),
            //TABLERO
            Flexible(
              flex:2,
              child:Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: 
                finPartida
                  //Hay jaque mate
                  ? JaqueMate(esColorBlanca: !esTurnoBlancas)
                  :  
                  GridView.builder(
                        itemCount: 8 * 8,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 8),
                        itemBuilder: (context, index) {
                          int fila = index ~/ 8;
                          int columna = index % 8;
                      
                          bool seleccionada =
                              filaSeleccionada == fila && columnaSeleccionada == columna;
                      
                          bool esValido = false;
                          for (var position in movimientosValidos) {
                            if (position[0] == fila && position[1] == columna) {
                              esValido = true;
                              break;
                            }
                          }
                      
                          return CasillaAjedrez(
                            seleccionada: seleccionada,
                            esBlanca: esBlanca(index),
                            pieza: tablero[fila][columna],
                            esValido: esValido,
                            onTap: () => seleccionadaPieza(fila, columna),
                          );
                        },
                      )
              ),
            ),
            Column(
              children: [
                Padding(padding: 
                  EdgeInsets.symmetric(horizontal: 7.0),
                  child: player2,
                ),
              ]
            ),
            SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                !finPartida && posibleRendicion
                    ? 
                    Container(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
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
                                    GoRouter.of(context).go('/chess');
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
              ],
            ),
          ],
        )
      )
    );
  }  
}
