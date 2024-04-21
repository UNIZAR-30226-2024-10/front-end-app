// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/board.jpg"),
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
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/Logo.png'),
              ),
              SizedBox(height: 16),
              Text(
                'Username',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(255, 136, 0, 1)),
              ),
              SizedBox(height: 8),
              Text(
                'Elo: 1800',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'W/L: 33/10',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
