import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Coronacion extends StatelessWidget {

  Coronacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
            child: Text(
              'Pieza a coronar',
              style: GoogleFonts.play(
                fontSize: 25,
                color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
          );
  }
  }