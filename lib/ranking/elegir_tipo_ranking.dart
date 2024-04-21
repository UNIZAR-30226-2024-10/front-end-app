import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../style/header.dart';

class ElegirTipoRanking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          title: Text('Elegir Tipo de Ranking',
              style: TextStyle(color: Colors.white, fontFamily: 'Oswald')),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.go('/ranking/blitz');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18)),
                ),
                child: Text('BLITZ',
                    style: TextStyle(color: Color.fromRGBO(49, 45, 45, 1))),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.go('/ranking/rapid');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18)),
                ),
                child: Text('RAPID',
                    style: TextStyle(color: Color.fromRGBO(49, 45, 45, 1))),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.go('/ranking/bullet');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18)),
                ),
                child: Text('BULLET',
                    style: TextStyle(color: Color.fromRGBO(49, 45, 45, 1))),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
