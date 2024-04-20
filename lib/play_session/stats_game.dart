import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayerRow extends StatefulWidget {
  final String playerName;
  final Duration initialTime;
  final bool esBlanca;

  const PlayerRow({
    Key? key,
    required this.playerName,
    required this.initialTime,
    required this.esBlanca,
  }) : super(key: key);

  @override
  _PlayerRowState createState() => _PlayerRowState();
}

class _PlayerRowState extends State<PlayerRow> {
  late int piecesCaptured;
  late Timer _timer;
  late Duration _elapsedTime;
  bool _timerPaused = false;

  @override
  void initState() {
    super.initState();
    piecesCaptured = 0;
    _elapsedTime = widget.initialTime;
    _timer = Timer.periodic(Duration(seconds: 1), _incrementTimer);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _incrementTimer(Timer timer) {
    if (!_timerPaused) {
      setState(() {
        _elapsedTime -= Duration(seconds: 1);
      });
    }
  }

  void incrementPiecesCaptured() {
    setState(() {
      piecesCaptured++;
    });
  }

  void pauseTimer() {
    setState(() {
      _timerPaused = true;
    });
  }

  void resumeTimer() {
    setState(() {
      _timerPaused = false;
    });
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
          SizedBox(width: 50),
          Align(
            alignment: Alignment.centerRight,
            child : Text(
            'Fichas comidas: $piecesCaptured',
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
