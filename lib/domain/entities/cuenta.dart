import 'movimiento.dart';

class Cuenta {
  String nombre;
  int cupo;
  int deuda;
  String red;
  List<Movimiento> movimientos;

  Cuenta({
    required this.nombre,
    required this.cupo,
    required this.deuda,
    required this.red,
    this.movimientos = const [],
  });
}
