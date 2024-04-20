import 'dart:async';
import 'package:ChessHub/game_internals/funciones.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayerRow extends StatefulWidget {
  final String playerName;
  Duration initialTime;
  final bool esBlanca;
  //Si es bñanca es true, si es negra es false
  bool _timerPaused = true;
  int piecesCaptured = 0;

  PlayerRow({
    Key? key,
    required this.playerName,
    required this.initialTime,
    required this.esBlanca,
  }) : super(key: key);

  void changeTimer(Duration newTime) {
    this.initialTime = newTime;
    if(esBlanca){
      this._timerPaused = false;
    }
  }

  void pauseTimer() {
    this._timerPaused = true;
  }

  void resumeTimer() {
    this._timerPaused = false;
  }

  void incrementPiecesCaptured() {
    this.piecesCaptured++;
  }

 
  @override
  _PlayerRowState createState() => _PlayerRowState();

}

class _PlayerRowState extends State<PlayerRow> {
  late Timer _timer;
  late Duration _elapsedTime;

  @override
  void initState() {
    super.initState();
    _elapsedTime = widget.initialTime;
    _timer = Timer.periodic(Duration(seconds: 1), _decrementTimer);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _decrementTimer(Timer timer) {
    if (!widget._timerPaused) {
      setState(() {
        _elapsedTime -= Duration(seconds: 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[300],
        border: Border.all(color: Colors.white, width: 1), // Borde blanco de 2 píxeles de ancho
      ),
      width: double.infinity,
      height: 70,
      child: Row(
        children: [
          SizedBox(width: 20),
          Text(
          widget.playerName,
          style: GoogleFonts.play(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 90),
          Align(
              alignment: Alignment.center,
              child:Text(
                '${_elapsedTime.inMinutes} : ${_elapsedTime.inSeconds % 60}',
                style: GoogleFonts.play(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
            ),
          ),
          SizedBox(width: 40),
          Align(
            alignment: Alignment.centerRight,
            child : Text(
            'Fichas comidas: ' + widget.piecesCaptured.toString(),
            style: GoogleFonts.play(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          ),
        ]
      )
    );
  }
}
