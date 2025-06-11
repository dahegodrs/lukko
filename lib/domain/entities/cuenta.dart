import 'movimiento.dart';

class Cuenta {
  final String nombre;
  final int cupo;
  final int deuda;
  final String red;
  final List<Movimiento> movimientos;

  Cuenta({
    required this.nombre,
    required this.cupo,
    required this.deuda,
    required this.red,
    this.movimientos = const [],
  });
}
