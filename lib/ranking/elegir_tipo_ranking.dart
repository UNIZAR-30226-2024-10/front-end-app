import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ElegirTipoRanking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elegir Tipo de Ranking', style: TextStyle(color: Colors.orange)),
      ),
      backgroundColor: Color.fromRGBO(49, 45, 45, 1),
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
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18)),
              ),
              child: Text('BLITZ'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/ranking/rapid');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18)),
              ),
              child: Text('RAPID'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/ranking/bullet');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18)),
              ),
              child: Text('BULLET'),
            ),
          ],
        ),
      ),
    );
  }
}
