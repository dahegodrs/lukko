import 'package:flutter/material.dart';
import 'package:lukko/domain/entities/cuenta.dart';

class CuentasProvider extends ChangeNotifier {
  final List<Cuenta> _cuentas = [
    Cuenta(nombre: "Cuenta Nómina", cupo: 3000000, deuda: 500000, red: "Visa"),
    Cuenta(
      nombre: "Cuenta Ahorros",
      cupo: 1000000,
      deuda: 100000,
      red: "Mastercard",
    ),
    Cuenta(
      nombre: "Cuenta Corriente",
      cupo: 2500000,
      deuda: 900000,
      red: "Discover",
    ),
  ];

  List<Cuenta> get cuentas => List.unmodifiable(_cuentas);

  void agregarCuenta(Cuenta nuevaCuenta) {
    _cuentas.add(nuevaCuenta);
    notifyListeners();
  }

  int get sumaCupo => _cuentas.fold(0, (sum, c) => sum + c.cupo);
  int get sumaDeuda => _cuentas.fold(0, (sum, c) => sum + c.deuda);
}
