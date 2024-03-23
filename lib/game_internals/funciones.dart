//Nombre: funciones.dart
//Descripción: Contiene las funciones necesarias para el juego de ajedrez.

bool esBlanca(int index){
  int x = index ~/8;
  int y = index % 8;
  bool res = (x + y) % 2 == 0;

  return res; 
}