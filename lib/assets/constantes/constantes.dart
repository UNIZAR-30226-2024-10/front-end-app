// TODO Implement this library.

enum TipoPieza { PEON, TORRE, ALFIL, CABALLO, DAMA, REY, REINA}

// Define un mapa que asocie cada posición de fila con un tipo de pieza de ajedrez
final Map<int, TipoPieza> posicionPiezaMap = {
  0: TipoPieza.TORRE,
  1: TipoPieza.CABALLO,
  2: TipoPieza.ALFIL,
  3: TipoPieza.REINA,
  4: TipoPieza.REY,
  5: TipoPieza.ALFIL,
  6: TipoPieza.CABALLO,
  7: TipoPieza.TORRE,
};
