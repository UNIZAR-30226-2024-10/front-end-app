import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../log_in/log_in_screen.dart';
import 'package:provider/provider.dart';

class ElegirTipoRanking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginState loginState = Provider.of<LoginState>(context, listen: true);
    int id = loginState.id;
    bool logueado = loginState.logueado;
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
                  if(logueado){
                    context.go('/ranking/blitz');
                  }
                  else{
                    context.go('/login');
                  }
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
                  if(logueado){
                    context.go('/ranking/rapid');
                  }
                  else{
                    context.go('/login');
                  }
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
                  if(logueado){
                    context.go('/ranking/bullet');
                  }
                  else{
                    context.go('/login');
                  }
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
