//Nombre: tablero_screen.dart
//Descripción: Contiene la pantalla de juego de ajedrez.

import 'package:ChessHub/play_session/pieza_ajedrez.dart';
import 'package:flutter/material.dart';
import 'package:ChessHub/play_session/casilla_ajedrez.dart';
import 'package:ChessHub/constantes/constantes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para manejar la codificación y decodificación JSON
import 'dart:io'; // Para leer archivos
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ChessHub/play_session/pieza_ajedrez.dart';
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

  Map<String, dynamic> jsonMapMovimientos = {};

  @override
  void initState() {
    super.initState();
    _inicializarTablero();
    _postTableroInicial();
  }

  //Función que envía al backend un tablero nuevo de ajedrez
  Future<void> _postTableroInicial() async {
    // Lee el contenido del archivo JSON
    String jsonString = await rootBundle.loadString('assets/json/tableroInicial.json');

    // Construye la URL y realiza la solicitud POST
    Uri uri = Uri.parse('http://localhost:3001/play/');
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
      //Decodifica la respuesta JSON
      jsonMapMovimientos = jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Error en la solicitud POST: ${response.statusCode}');
    }
    
    print('PRUEBA DE CORRECTO LISTADO DE MOVIMIENTOS VÁLIDOS\n');
    //Recorremos el mapa de movimientos válidos
    print(jsonMapMovimientos['allMovements']['peones'][0][1]);
    //List<List<int>> movimientosValidos = calcularMovimientosValidos(0, 2, PiezaAjedrez(tipoPieza: TipoPieza.PEONES, esBlanca: true, nombreImagen: 'assets/images/pawn-w.svg'));
  }

  //CALCULAR MOVIMIENTOS POSIBLES
  List<List<int>> calcularMovimientosValidos(int fila, int columna, PiezaAjedrez? tipoPieza){
    List<List<int>> movimientosValidos = [];

    String pieza;
    //Obtenemos el nombre de la pieza
    pieza = nombrePieza(tipoPieza);

    List<int> movimientosLista = jsonMapMovimientos['allMovements'][tipoPieza] as List<int>;
    List<List<int>> movimientosListaLista = jsonMapMovimientos['allMovements'][pieza] as List<List<int>>;

    //Recorremos el mapa de movimientos válidos
    for(int i = 0; i < movimientosLista.length; i++){
      //Si la posición de la pieza es igual a la posición de la pieza en el mapa
      if(jsonMapMovimientos['allMovements'][pieza][i][0] == fila && jsonMapMovimientos['allMovements'][pieza][i][1] == columna){
        //Añadimos los movimientos válidos a la lista
        movimientosValidos.add(movimientosListaLista[i]);
      }
    }
    return movimientosValidos;
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
        tipoPieza: TipoPieza.reinas,
        esBlanca: false,
        nombreImagen: 'assets/images/queen-b.svg');
    nuevoTablero[7][4] = PiezaAjedrez(
        tipoPieza: TipoPieza.reinas,
        esBlanca: true,
        nombreImagen: 'assets/images/queen-w.svg');
    //Place kings
    nuevoTablero[0][4] = PiezaAjedrez(
        tipoPieza: TipoPieza.reyes,
        esBlanca: false,
        nombreImagen: 'assets/images/king-b.svg');
    nuevoTablero[7][3] = PiezaAjedrez(
        tipoPieza: TipoPieza.reyes,
        esBlanca: true,
        nombreImagen: 'assets/images/king-w.svg');

    tablero = nuevoTablero;
  }

  void seleccionadaPieza(int fila, int columna) {
    setState(() {
      if (tablero[fila][columna] != null) {
        piezaSeleccionada = tablero[fila][columna];
        filaSeleccionada = fila;
        columnaSeleccionada = columna;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
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

                return CasillaAjedrez(
                  seleccionada: seleccionada,
                  esBlanca: esBlanca(index),
                  pieza: tablero[fila][columna],
                  onTap: () => seleccionadaPieza(fila, columna),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => GoRouter.of(context).go('/'),
              child: const Text('Back'),
            ),
          ),
        ],
      ),
    );
  }
}
