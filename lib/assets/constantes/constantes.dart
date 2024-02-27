// TODO Implement this library.

enum TipoPieza { peon, torre, alfil, caballo, dama, rey, reina}

// Define un mapa que asocie cada posición de fila con un tipo de pieza de ajedrez
final Map<int, TipoPieza> posicionPiezaMap = {
  0: TipoPieza.torre,
  1: TipoPieza.caballo,
  2: TipoPieza.alfil,
  3: TipoPieza.reina,
  4: TipoPieza.rey,
  5: TipoPieza.alfil,
  6: TipoPieza.caballo,
  7: TipoPieza.torre,
};
