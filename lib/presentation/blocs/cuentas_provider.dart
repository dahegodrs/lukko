import 'package:flutter/material.dart';
import 'package:lukko/domain/entities/cuenta.dart';
import 'package:lukko/domain/entities/movimiento.dart';

class CuentasProvider extends ChangeNotifier {
  final List<Cuenta> _cuentas = [
    Cuenta(
      nombre: "Cuenta Nómina",
      cupo: 3000000,
      deuda: 600000,
      red: "Visa",
      movimientos: [
        Movimiento(
          titulo: "Abono nómina",
          descripcion: "Depósito mensual",
          categoria: "Ingreso",
          valor: 300000,
          tipo: "ingreso",
        ),
        Movimiento(
          titulo: "Pago de Arriendo",
          descripcion: "Arriendo casa",
          categoria: "Gasto",
          valor: 400000,
          tipo: "gasto",
        ),
        Movimiento(
          titulo: "Pago de Servicios",
          descripcion: "Arriendo casa",
          categoria: "Gasto",
          valor: 200000,
          tipo: "gasto",
        ),
      ],
    ),
    Cuenta(
      nombre: "Cuenta Ahorros",
      cupo: 1000000,
      deuda: 100000,
      red: "Mastercard",
      movimientos: [
        Movimiento(
          titulo: "Transferencia a ahorros",
          descripcion: "Ahorro mensual",
          categoria: "Ahorros",
          valor: 200000,
          tipo: "ingreso",
        ),
      ],
    ),
    Cuenta(
      nombre: "Cuenta Corriente",
      cupo: 2500000,
      deuda: 900000,
      red: "Discover",
      movimientos: [
        Movimiento(
          titulo: "Pago de luz y agua",
          descripcion: "Factura de luz y agua",
          categoria: "Servicios",
          valor: 350000,
          tipo: "gasto",
        ),
      ],
    ),
  ];

  List<Cuenta> get cuentas => List.unmodifiable(_cuentas);

  void agregarCuenta(Cuenta nuevaCuenta) {
    _cuentas.add(nuevaCuenta);
    notifyListeners();
  }

  void agregarMovimiento(int cuentaIndex, Movimiento movimiento) {
    _cuentas[cuentaIndex].movimientos.add(movimiento);
    recalcularTotales(cuentaIndex);
    notifyListeners();
  }

  void editarMovimiento({
    required int indexCuenta,
    required int indexMovimiento,
    required Movimiento nuevoMovimiento,
  }) {
    if (indexCuenta >= 0 &&
        indexCuenta < _cuentas.length &&
        indexMovimiento >= 0 &&
        indexMovimiento < _cuentas[indexCuenta].movimientos.length) {
      _cuentas[indexCuenta].movimientos[indexMovimiento] = nuevoMovimiento;
      notifyListeners();
    }
  }

  void recalcularTotales(int indexCuenta) {
    final cuenta = _cuentas[indexCuenta];

    int ingresos = 0;
    int gastos = 0;

    for (var movimiento in cuenta.movimientos) {
      if (movimiento.tipo == 'ingreso') {
        ingresos += movimiento.valor;
      } else if (movimiento.tipo == 'gasto') {
        gastos += movimiento.valor;
      }
    }

    cuenta.cupo = ingresos; // cupo disponible actual = total ingresos
    cuenta.deuda = gastos; // deuda actual = total gastos

    notifyListeners();
  }

  int get sumaCupo => _cuentas.fold(0, (sum, c) => sum + c.cupo);
  int get sumaDeuda => _cuentas.fold(0, (sum, c) => sum + c.deuda);
}
