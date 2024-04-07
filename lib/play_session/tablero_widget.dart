//Nombre: tablero_screen.dart
//Descripción: Contiene la pantalla de juego de ajedrez.

//import 'dart:ffi';

import 'package:ChessHub/play_session/pieza_ajedrez.dart';
import 'package:flutter/material.dart';
import 'package:ChessHub/play_session/casilla_ajedrez.dart';
import 'package:ChessHub/constantes/constantes.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para manejar la codificación y decodificación JSON
import 'dart:io'; // Para leer archivos
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ChessHub/play_session/pieza_ajedrez.dart';
import 'package:ChessHub/play_session/piezaMuerta.dart';
import 'package:ChessHub/game_internals/funciones.dart';
//import 'package:ChessHub/play_session/pieza_ajedrez_widget.dart';
//import 'package:provider/provider.dart';

class TableroAjedrez extends StatefulWidget {
  const TableroAjedrez({super.key});

  @override
  State<TableroAjedrez> createState() => _TableroAjedrezState();
}

class _TableroAjedrezState extends State<TableroAjedrez> {
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

  bool esTurnoBlancas = true;

  @override
  void initState() {
    super.initState();
    _cargarTableroInicial();
    _inicializarTablero();
  }

  void _cargarTableroInicial() async {
    // Cargar el tablero inicial
    jsonString = await rootBundle.loadString('assets/json/tableroInicial.json');
    jsonMapTablero = jsonDecode(jsonString) as Map<String, dynamic>;
    _postTablero();
  }

  //Función que envía al backend un tablero nuevo de ajedrez
  Future<bool> _postTablero() async {
    // Construye la URL y realiza la solicitud POST
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
      print('La solicitud POST fue exitosa');
      //Decodifica la respuesta JSON
      jsonMapMovimientos = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonMapMovimientos['jugadaLegal'] == false) {
        return false;
      }
      return true;
    } else {
      throw Exception('Error en la solicitud POST: ${response.statusCode}');
    }
    //prueba, borrar en la entrega final
    /*
    print('PRUEBA DE CORRECTO LISTADO DE MOVIMIENTOS VÁLIDOS\n');
    //Recorremos el mapa de movimientos válidos
    List<String> movimientosValidos = obtenerMovimientosValidos(1, 0, PiezaAjedrez(tipoPieza: TipoPieza.peones, esBlanca: true, nombreImagen: 'assets/images/pawn-w.svg'));
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

  //Función que inicializa el tablero de ajedrez
  void _inicializarTablero() {
    List<List<PiezaAjedrez?>> nuevoTablero =
        List.generate(8, (index) => List.generate(8, (index) => null));

    //Place pawn
    for (int i = 0; i < 8; i++) {
      nuevoTablero[1][i] = PiezaAjedrez(
          tipoPieza: TipoPieza.peones,
          esBlanca: false,
          nombreImagen: 'assets/images/pawn-b.svg');

      nuevoTablero[6][i] = PiezaAjedrez(
          tipoPieza: TipoPieza.peones,
          esBlanca: true,
          nombreImagen: 'assets/images/pawn-w.svg');
    }

    //Place rooks
    nuevoTablero[0][0] = PiezaAjedrez(
        tipoPieza: TipoPieza.torres,
        esBlanca: false,
        nombreImagen: 'assets/images/rook-b.svg');
    nuevoTablero[0][7] = PiezaAjedrez(
        tipoPieza: TipoPieza.torres,
        esBlanca: false,
        nombreImagen: 'assets/images/rook-b.svg');
    nuevoTablero[7][0] = PiezaAjedrez(
        tipoPieza: TipoPieza.torres,
        esBlanca: true,
        nombreImagen: 'assets/images/rook-w.svg');
    nuevoTablero[7][7] = PiezaAjedrez(
        tipoPieza: TipoPieza.torres,
        esBlanca: true,
        nombreImagen: 'assets/images/rook-w.svg');

    //Place knights
    nuevoTablero[0][1] = PiezaAjedrez(
        tipoPieza: TipoPieza.caballos,
        esBlanca: false,
        nombreImagen: 'assets/images/knight-b.svg');
    nuevoTablero[0][6] = PiezaAjedrez(
        tipoPieza: TipoPieza.caballos,
        esBlanca: false,
        nombreImagen: 'assets/images/knight-b.svg');
    nuevoTablero[7][1] = PiezaAjedrez(
        tipoPieza: TipoPieza.caballos,
        esBlanca: true,
        nombreImagen: 'assets/images/knight-w.svg');
    nuevoTablero[7][6] = PiezaAjedrez(
        tipoPieza: TipoPieza.caballos,
        esBlanca: true,
        nombreImagen: 'assets/images/knight-w.svg');

    //Place bishops
    nuevoTablero[0][2] = PiezaAjedrez(
        tipoPieza: TipoPieza.alfiles,
        esBlanca: false,
        nombreImagen: 'assets/images/bishop-b.svg');
    nuevoTablero[0][5] = PiezaAjedrez(
        tipoPieza: TipoPieza.alfiles,
        esBlanca: false,
        nombreImagen: 'assets/images/bishop-b.svg');
    nuevoTablero[7][2] = PiezaAjedrez(
        tipoPieza: TipoPieza.alfiles,
        esBlanca: true,
        nombreImagen: 'assets/images/bishop-w.svg');
    nuevoTablero[7][5] = PiezaAjedrez(
        tipoPieza: TipoPieza.alfiles,
        esBlanca: true,
        nombreImagen: 'assets/images/bishop-w.svg');

    //Place queens
    nuevoTablero[0][3] = PiezaAjedrez(
        tipoPieza: TipoPieza.damas,
        esBlanca: false,
        nombreImagen: 'assets/images/queen-b.svg');
    nuevoTablero[7][3] = PiezaAjedrez(
        tipoPieza: TipoPieza.damas,
        esBlanca: true,
        nombreImagen: 'assets/images/queen-w.svg');
    //Place kings
    nuevoTablero[0][4] = PiezaAjedrez(
        tipoPieza: TipoPieza.reyes,
        esBlanca: false,
        nombreImagen: 'assets/images/king-b.svg');
    nuevoTablero[7][4] = PiezaAjedrez(
        tipoPieza: TipoPieza.reyes,
        esBlanca: true,
        nombreImagen: 'assets/images/king-w.svg');

    tablero = nuevoTablero;
  }

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
      }
      else{
        piezasNegrasMuertas.add(tablero[filaNueva][columnaNueva]!);
      }
      //si se trata de una muerte, debemos eliminar la pieza del tablero
      jsonMapTablero.forEach((tipoPieza, listaPiezas) {
        if (listaPiezas is List) {
          // Filtra la lista de piezas para eliminar la pieza con las coordenadas dadas
          listaPiezas.removeWhere((pieza) => pieza['x'] == coordenadasNuevasApi[0] && pieza['y'] == coordenadasNuevasApi[1]);
        }
      });
    }

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

    if (esTurnoBlancas) {
      jsonMapTablero['turno'] = 'negras';
      esTurnoBlancas = false;
    } else {
      jsonMapTablero['turno'] = 'blancas';
      esTurnoBlancas = true;
    }

    jsonString = jsonEncode(jsonMapTablero);

    //enviamos el tablero con la posible jugada
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

    print('Jugada valida');
    tablero[filaNueva][columnaNueva] = piezaSeleccionada;
    tablero[filaSeleccionada][columnaSeleccionada] = null;

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
      body: Column(
        children: [
          //PIEZAS BLANCAS MUERTAS
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

          //TABLERO
          Expanded(
            flex:3,
            child: GridView.builder(
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
            ),
          ),

          //PIEZAS NEGRAS MUERTAS
          Expanded(
            child: GridView.builder(
              itemCount: piezasNegrasMuertas.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8),
              itemBuilder: (context, index) => PiezaMuerta(
                pathImagen: piezasNegrasMuertas[index].nombreImagen,
                esBlanca: false,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => GoRouter.of(context).go('/'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(255, 136, 0, 1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              child: const Text('Back',
                  style: TextStyle(color: Color.fromRGBO(49, 45, 45, 1))),
            ),
          ),
        ],
      ),
    );
  }
}
