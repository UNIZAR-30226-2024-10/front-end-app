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
import 'package:ChessHub/partidas_asincronas/seleccionar_id_rival.dart';
import 'package:ChessHub/partidas_asincronas/pantalla_partida_asincrona.dart';

class Partidas {
  int idPartida;
  int usuarioblancasid;
  int usuarionegrasid;
  String tablero;

  Partidas({required this.idPartida, required this.usuarioblancasid, required this.usuarionegrasid, required this.tablero});

  Partidas.fromJson(Map<String, dynamic> json)
      : idPartida = json['id'] as int,
        usuarioblancasid = json['usuarioblancasid'] as int,
        usuarionegrasid = json['usuarionegrasid'] as int,
        tablero = json['tablero'] as String;
}




class PartidasAsincronas extends StatefulWidget {
  int id = 0;
  PartidasAsincronas({Key? key, required this.id}) : super(key: key);
  @override
  _PartidasAsincronas createState() => _PartidasAsincronas();
}



class _PartidasAsincronas extends State<PartidasAsincronas> {
  int id = 0;
  List<Partidas> partidas = [];
  @override
  void initState() {
    id = widget.id;
    super.initState();
    _establecerDatosUsuario();
  }

  Future<void> _establecerDatosUsuario() async {
    final url = Uri.parse('https://chesshub-api-ffvrx5sara-ew.a.run.app/users/get_partidas_asincronas/$id');
    final response = await http.get(url);
    if(response.statusCode == 200) {
      print('Leidas correctamente');
      final userMap = jsonDecode(response.body) as List<dynamic>;
      userMap.forEach((userData){
        partidas.add(Partidas.fromJson(userData as Map<String, dynamic>));
      });
      setState(() {
        partidas = partidas;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(builder: (context,value,child)=> Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/board2.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(backgroundColor: Color.fromRGBO(49, 45, 45, 1),
            title: Text(
              'Partidas Asíncronas',
              style: TextStyle(color: Colors.white, fontFamily: 'Oswald'),
            ),
          ),
          body: Container(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SeleccionarIdRival(id: value.id)));
                    },
                    child: Text('Crear Partida Asíncrona', style: TextStyle(color: Colors.green, fontFamily: 'Oswald'),),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: partidas.length,
                    itemBuilder: (context, index) {
                      final ind = partidas[index];
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(
                          vertical: 8,horizontal: 16),
                          color: Color.fromRGBO(49,45,45,1),
                          child : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children : [
                                Text(
                                    'Partida con ID:${ind.idPartida} VS usuario con ID: ${(id == ind.usuarioblancasid) ? ind.usuarionegrasid : ind.usuarioblancasid}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Oswald',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                ElevatedButton(
                                  
                                  onPressed: (){ 
                                    int idPartida = ind.idPartida;
                                    int idUsuario = id;
                                    int idRival = (id == ind.usuarioblancasid) ? ind.usuarionegrasid : ind.usuarioblancasid;
                                    String tablero = ind.tablero;
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PartidaAsincrona(idPartida: idPartida, idUsuario: idUsuario, idRival: idRival, tablero: tablero)));},
                                  child: Text('Jugar Partida', style: TextStyle(color: Colors.black, fontFamily: 'Oswald'),)
                                )
                            ],
                          ),
                        
                            
                          ),
                      );
                    }
                  )
                ),
              ]
            )
          )
        )
      ],
      )
    );
  }
  
}