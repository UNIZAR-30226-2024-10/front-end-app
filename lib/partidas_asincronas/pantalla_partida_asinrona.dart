import 'dart:async';
import 'dart:ui';

import 'package:ChessHub/battle_pass/battle_pass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../log_in/log_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ChessHub/partidas_asincronas/menu_partidas_asincronas.dart';


class PartidaAsincrona extends StatefulWidget {
  int id = 0;
  PartidaAsincrona({Key? key, required this.id, required this.idUsuario, required this.idRival, required this.tablero}) : super(key: key);
  
  @override
  PartidaAsincrona createState() => _PartidaAsincrona();
}

class _PartidaAsincrona extends State<PartidaAsincrona>{
  int id = 0;
  int idUsuario = 0;
  int idRival = 0;
  String tablero = '';

  void initState() {
    id = widget.id;
    idUsuario = widget.idUsuario;
    idRival = widget.idRival;
    tablero = widget.tablero;
    super.initState();
  }
}