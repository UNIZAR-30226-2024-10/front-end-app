//Nombre: pieza_ajedrez.dart
//Descripción: Contiene el widget de la pieza de ajedrez.

enum TipoPieza {peones, torres, alfiles, caballos, reyes, damas}

class PiezaAjedrez {
  final TipoPieza tipoPieza;
  final bool esBlanca;
  final String nombreImagen;

  PiezaAjedrez({
    required this.tipoPieza,
    required this.esBlanca,
    required this.nombreImagen,
  });
}



