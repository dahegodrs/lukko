class Movimiento {
  final String titulo;
  final String descripcion;
  final String categoria;
  final int valor;
  final String tipo; // "ingreso" o "gasto"

  Movimiento({
    required this.titulo,
    required this.descripcion,
    required this.categoria,
    required this.valor,
    required this.tipo,
  });
}
