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
              child: Text('Piezas'),
            ),
            SizedBox(height:20),
            ElevatedButton(
              onPressed: () {
                // Lógica para el segundo botón
              },
              child: Text('Reacciones'),
            ),
            SizedBox(height:20),
            ElevatedButton(
              onPressed: () {
                // Lógica para el tercer botón
              },
              child: Text('LO QUE SEA'),
            ),
            SizedBox(height:300), // Añade espacio antes del botón 'Back'
            MyButton(
              onPressed: () => GoRouter.of(context).go('/'),
              child: const Text('Back'),
            ),
            SizedBox(height:20), // Añade espacio después del botón 'Back'
            MyButton(
              onPressed: () => GoRouter.of(context).go('/'),
              child: const Text('GUARDAR'),
            ),
          ],
        ),
      ),
    );
  }
}