// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'log_in_screen.dart';
import '../settings/settings.dart';
import 'package:provider/provider.dart';

class User {
  final int id;
  final String nombre;
  final int elo;

  User({required this.id, required this.nombre, required this.elo});

  // Constructor factory para crear un objeto User desde un mapa JSON
  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        nombre = json['nombre'] as String,
        elo = json['elo'] as int;
}

String _username = '';
String _mail = '';
int _eloBlitz = 0;
int _eloRapid = 0;
int _eloBullet = 0;
int _victorias = 0;
int _derrotas = 0;
int _empates = 0;

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();

    void _getInfo(int id) async {
      // Construye la URL y realiza la solicitud POST
      //http://192.168.1.97:3001/play/
      print('OBTENIENDO INFORMACION DE USUARIO\n');
      Uri uri =
          Uri.parse('http://192.168.1.97:3001/users/$id');
      http.Response response = await http.get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader:
              'application/json', // Especifica el tipo de contenido como JSON
        },
      );
      print('OBTENEIENDO DATOS DE USUARIO');
      Map<String, dynamic> res =
          jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        print(res);
        _eloBlitz = res['eloblitz'] as int;
        _eloRapid = res['elorapid'] as int;
        _eloBullet = res['elobullet'] as int;
        _username = res['nombre'] as String;
        _mail = res['correo'] as String;
        _victorias = res['victorias'] as int;
        _derrotas = res['derrotas'] as int;
        _empates = res['empates'] as int;
      } else {
        throw Exception('Error en la solicitud GET: ${response.statusCode}');
      }
    }

    int id = settingsController.session.value;
    _getInfo(id);

    print(id);

    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/board2.jpg"),
            fit: BoxFit.fill,
          ),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(49, 45, 45, 1),
          title: Text('Perfil de Usuario',
              style: TextStyle(color: Colors.white, fontFamily: 'Oswald')),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                color: Color.fromRGBO(49, 45, 45, 1),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/Logo.png'),
                  ),
                  SizedBox(width: 16),
                  Text(
                    "$_username\n$_mail",
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(255, 136, 0, 1)),
                  ),
                ]),
              ),
              SizedBox(height: 16),
              Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                color: Color.fromRGBO(49, 45, 45, 1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Elo blitz: $_eloBlitz \nElo rapid: $_eloRapid \nElo bullet: $_eloBullet",
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(255, 136, 0, 1)),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                color: Color.fromRGBO(49, 45, 45, 1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Victorias: $_victorias \nDerrotas: $_derrotas \nEmpates: $_empates",
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(255, 136, 0, 1)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
