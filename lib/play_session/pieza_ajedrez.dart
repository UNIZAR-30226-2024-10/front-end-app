//Nombre: pieza_ajedrez.dart
//Descripción: Contiene el widget de la pieza de ajedrez.

enum TipoPieza {peon, torre, alfil, caballo, rey, dama}

class PiezaAjedrez {
  final TipoPieza tipoPieza;
  final bool esBlanca;
  final String nombreImagen;
  bool ladoIzquierdo;

  PiezaAjedrez({
    required this.tipoPieza,
    required this.esBlanca,
    required this.nombreImagen,
    this.ladoIzquierdo = false,
  });
}



