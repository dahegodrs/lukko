import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lukko/presentation/blocs/cuentas_provider.dart';
import 'package:lukko/presentation/screens/newaccounts/new_account.dart';
import 'package:lukko/domain/entities/cuenta.dart';
import 'package:lukko/core/theme/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData obtenerIconoRed(String red) {
  switch (red.toLowerCase()) {
    case 'visa':
      return FontAwesomeIcons.ccVisa;
    case 'mastercard':
      return FontAwesomeIcons.ccMastercard;
    case 'amex':
      return FontAwesomeIcons.ccAmex;
    case 'diners club':
      return FontAwesomeIcons.ccDinersClub;
    case 'maestro':
      return FontAwesomeIcons.ccMastercard;
    case 'discover':
      return FontAwesomeIcons.ccDiscover;
    default:
      return Icons.credit_card; // Ícono genérico
  }
}

class AccountListScreen extends StatelessWidget {
  const AccountListScreen({super.key});

  String _formatearMoneda(int valor) {
    return '\$${valor.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    final cuentasProvider = Provider.of<CuentasProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      appBar: AppBar(
        title: const Text('Listado de cuentas'),
        backgroundColor: AppColors.darkGrey,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<CuentasProvider>(
          builder: (context, provider, _) {
            final cuentas = provider.cuentas;

            return ListView.builder(
              itemCount: cuentas.length,
              itemBuilder: (context, index) {
                final cuenta = cuentas[index];
                return Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                cuenta.nombre,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkGrey,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black26,
                                      offset: Offset(1, 1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Icon(
                              obtenerIconoRed(cuenta.red),
                              color: Color(0xFFA8A8A8),
                              size: 20,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Cupo: ',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                text: _formatearMoneda(cuenta.cupo),
                                style: const TextStyle(
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Deuda: ',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: _formatearMoneda(cuenta.deuda),
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(
                                Icons.remove_red_eye,
                                color: Color(0xFFA8A8A8),
                              ),
                              onPressed: () {
                                debugPrint('Ver detalles de ${cuenta.nombre}');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color.fromRGBO(1, 209, 219, 1),
        unselectedItemColor: Colors.grey,
        currentIndex: 1, // puedes manejar el índice si quieres
        onTap: (index) async {
          switch (index) {
            case 0:
              Navigator.pop(
                context,
              ); // O ir a la pantalla home si tienes ruta nombrada
              break;
            case 1:
              final nuevaCuenta = await Navigator.push<Cuenta>(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewAccountScreen(),
                ),
              );
              if (nuevaCuenta != null) {
                cuentasProvider.agregarCuenta(nuevaCuenta);
              }
              break;
            case 2:
              // Aquí pon la navegación al menú o configuración
              // Por ejemplo:
              // Navigator.pushNamed(context, '/menu');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Agregar'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menú'),
        ],
      ),
    );
  }
}
