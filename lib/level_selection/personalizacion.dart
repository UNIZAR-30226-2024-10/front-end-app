import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../style/my_button.dart';

class Personalizacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personalización'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Lógica para el primer botón
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              child: Text('Piezas',
                  style: TextStyle(color: Color.fromRGBO(49, 45, 45, 1))),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para el segundo botón
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              child: Text('Reacciones',
                  style: TextStyle(color: Color.fromRGBO(49, 45, 45, 1))),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para el tercer botón
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              child: Text('LO QUE SEA',
                  style: TextStyle(color: Color.fromRGBO(49, 45, 45, 1))),
            ),
            SizedBox(height: 300), // Añade espacio antes del botón 'Back'
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go('/'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(255, 136, 0, 1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              child: const Text('Back',
                  style: TextStyle(color: Color.fromRGBO(49, 45, 45, 1))),
            ),
            SizedBox(height: 20), // Añade espacio después del botón 'Back'
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go('/'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(255, 136, 0, 1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              child: const Text('GUARDAR',
                  style: TextStyle(color: Color.fromRGBO(49, 45, 45, 1))),
            ),
          ],
        ),
      ),
    );
  }
}
