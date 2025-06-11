import 'package:flutter/material.dart';
import 'package:lukko/core/theme/app_colors.dart';
import 'package:lukko/domain/entities/cuenta.dart';
import 'package:lukko/presentation/screens/newaccounts/new_account.dart';

class AccountDetailScreen extends StatelessWidget {
  final Cuenta cuenta;

  const AccountDetailScreen({super.key, required this.cuenta});

  String _formatearMoneda(int valor) {
    return '\$${valor.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      appBar: AppBar(
        title: const Text('Detalle de cuentas'),
        backgroundColor: AppColors.darkGrey,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 6,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0D0D0D), Color(0xFF1A1A1A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cuenta.nombre,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD4AF37),
                          shadows: [
                            Shadow(
                              color: Colors.grey.withAlpha(77),
                              blurRadius: 4,
                              offset: const Offset(1, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            "Red:",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            cuenta.red,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Cupo total disponible:",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            _formatearMoneda(cuenta.cupo),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Deuda actual:",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            _formatearMoneda(cuenta.deuda),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Movimientos",
                        style: TextStyle(
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
                      const SizedBox(height: 12),
                      cuenta.movimientos.isEmpty
                          ? const Center(
                              child: Text(
                                "No hay movimientos aún.",
                                style: TextStyle(color: AppColors.darkGrey),
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cuenta.movimientos.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemBuilder: (context, index) {
                                final movimiento = cuenta.movimientos[index];
                                final esGasto = movimiento.tipo == 'gasto';

                                return ListTile(
                                  leading: Icon(
                                    esGasto
                                        ? Icons.arrow_downward
                                        : Icons.arrow_upward,
                                    color: esGasto ? Colors.red : Colors.green,
                                  ),
                                  title: Text(
                                    movimiento.titulo,
                                    style: const TextStyle(
                                      color: AppColors.darkGrey,
                                    ),
                                  ),
                                  trailing: Text(
                                    _formatearMoneda(movimiento.valor),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: esGasto
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color.fromRGBO(1, 209, 219, 1),
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        onTap: (index) async {
          switch (index) {
            case 0:
              Navigator.pop(context);
              break;
            case 1:
              final nuevaCuenta = await Navigator.push<Cuenta>(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewAccountScreen(),
                ),
              );
              if (nuevaCuenta != null) {}
              break;
            case 2:
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Editar'),
          BottomNavigationBarItem(icon: Icon(Icons.back_hand), label: 'Volver'),
        ],
      ),
    );
  }
}
