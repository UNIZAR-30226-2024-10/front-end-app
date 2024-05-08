import 'package:flutter/material.dart';
import 'package:ChessHub/constantes/constantes.dart';
import 'package:ChessHub/game_internals/funciones.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:ChessHub/local_game_sesion/pieza_ajedrez.dart';
import 'package:ChessHub/online_game_sesion/tablero_online_widget.dart';
import 'package:ChessHub/log_in/log_in_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class EsperandoPartida extends StatefulWidget {
  final Modos modoJuego;
  IO.Socket socket;
  final int userId;
  final int elo;

  EsperandoPartida({required this.modoJuego, required this.socket, required this.userId, required this.elo});

  @override
  _EsperandoPartidaState createState() => _EsperandoPartidaState();
}

class _EsperandoPartidaState extends State<EsperandoPartida> {
  bool partidaEncontrada = false;
  bool partidaCancelada = false;
  late Modos modoJuego;
  late IO.Socket socket;
  late int id;
  late int eloRapid;
  int countdown = 5; // Inicializamos el contador en 10 segundos
  late int roomId = 0;
  late String myColor = '';
  late String idOponente = '';
  bool infoObtenida = false;

  @override
  void initState() {
    super.initState();
    modoJuego = widget.modoJuego;
    socket = widget.socket;
    id = widget.userId;
    eloRapid = widget.elo;
    _esperarPartida();
    _partidaEncontrada();
    _cancelarBusqueda();
  }

  
  void enviarPeticiondeJuego(Modos modo){
    //('join_room', { mode: 'Rapid' , userId: args.userInfo.userId , elo: args.userInfo.eloRapid})
    socket.emit('join_room', {"mode": obtenerModo(modo) , "userId": id , "elo": eloRapid});
  }

  void _startCountdown() {
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {
      if (mounted) {
        setState(() {
          if (countdown < 1) {
            timer.cancel(); 
            entrarEnPartida();
            // Detenemos el temporizador cuando el contador llega a cero
          } else {
            countdown--;
          }
        });
      }
    });
  }

  Future<void> _esperarPartida() async {
    enviarPeticiondeJuego(modoJuego);
    socket.on('game_ready', (data) {
      if (mounted) {
        setState(() {
          print('Datos de la partida: ');
          print(data);
          roomId = data['roomId'] as int;
          myColor = data['color'] as String;
          idOponente = data['opponent'] as String;
        });
        socket.off('game_ready');
      }
    });
  }

  Future<void> _partidaEncontrada() async {
    socket.on('match_found', (data) {
      if (mounted) {
        setState(() {
          partidaEncontrada = true;
        });
      }
      socket.off('match_found');
      _startCountdown();
    });
  }

  
  Future<void> _cancelarBusqueda() async {
    socket.on('match_canceled', (_) {
      if (mounted) {
        setState(() {
          partidaCancelada = true;
        });
      }
      socket.off('match_canceled');
      Future.delayed(Duration(seconds: 5), () {
        Navigator.pop(context);
      });
    });
  }
  

  void entrarEnPartida() async {
      // Navegar a la pantalla del tablero cuando countdown es igual a 0
    final login = context.read<LoginState>();
    login.getInfo(login.getId());
    List<List<PiezaAjedrez?>> tablero;
    List<Color> coloresTablero;
    tablero = inicializarTablero(login.imagen);
    coloresTablero = getColorCasilla(login.arena);
    String nombreUsuario = login.getNombre();
    String nombreOponente = 'kiko';
    Future<String> futureString = getNombre(idOponente);
    await futureString.then((value) {
      nombreOponente = value;
      print('Nombre del oponente: $nombreOponente');
      // Usa el valor de resultado aquí
    });


      Future.delayed(Duration.zero, () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TableroAjedrezOnline(
              modoJuego: Modos.BULLET,
              coloresTablero: coloresTablero,
              tablero: tablero,
              socket: socket,
              roomId: roomId,
              myColor: myColor,
              idOponente: idOponente,
              nombreUsuario: nombreUsuario,
              nombreOponente: nombreOponente,
              nombrePieza: login.getImagenPieza(),
            ),
          ),
        );
    });
  }
      
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(
    builder:(context,value,child) => Scaffold(
        appBar: AppBar(
          title: Text('Esperando partida'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: 
              Column(
                children: [
                if (partidaEncontrada)
                  if (partidaCancelada)
                    Text('La partida ha sido cancelada, redirigiendo a la pantalla anterior...')
                  else if (countdown > 0)
                    Text('Partida encontrada, comenzará en: $countdown segundos')
                  else
                    Text('Cargando la partida...')
                else
                  CircularProgressIndicator(),
                if (partidaCancelada)
                  Text('En unos instantes volverás a la pantalla anterior')
                else
                  ElevatedButton(
                    onPressed: () {
                      //ESTO NO VA
                      socket.emit('cancel_match');
                      socket.emit('cancel_search', {"mode": obtenerModo(modoJuego)});
                      socket.off('match_canceled');
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar búsqueda'),
                  ),
              ],
              ),

        ),
      ),
    );
  }
}
