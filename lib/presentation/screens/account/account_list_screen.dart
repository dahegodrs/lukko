import 'package:flutter/material.dart';
import 'package:lukko/core/theme/app_colors.dart';

class AccountListScreen extends StatefulWidget {
  const AccountListScreen({super.key});

  @override
  State<AccountListScreen> createState() => _AccountListScreenState();
}

class _AccountListScreenState extends State<AccountListScreen> {
  // Lista inicial de cuentas
  List<Map<String, String>> cuentas = [
    {'nombre': 'Cuenta Nómina', 'cupo': '\$3.000.000', 'deuda': '\$800.000'},
    {'nombre': 'Cuenta Ahorros', 'cupo': '\$1.000.000', 'deuda': '\$200.000'},
    {
      'nombre': 'Cuenta Corriente',
      'cupo': '\$2.500.000',
      'deuda': '\$1.100.000',
    },
  ];

  // Función para abrir pantalla de nueva cuenta y esperar resultado
  Future<void> _agregarNuevaCuenta() async {
    final nuevaCuenta = await Navigator.pushNamed(context, '/new-account');

    if (nuevaCuenta != null && nuevaCuenta is Map<String, String>) {
      setState(() {
        cuentas.add(nuevaCuenta);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      appBar: AppBar(
        title: const Text("Listado de cuentas"),
        backgroundColor: AppColors.darkGrey,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cuenta['nombre'] ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Cupo total:",
                        style: TextStyle(color: AppColors.primary),
                      ),
                      Text(
                        cuenta['cupo'] ?? '',
                        style: const TextStyle(
                          color: AppColors.aguamarina,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Deuda total:",
                        style: TextStyle(color: AppColors.primary),
                      ),
                      Text(
                        cuenta['deuda'] ?? '',
                        style: const TextStyle(
                          color: AppColors.lightcoral,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        // Aquí puedes implementar la vista detallada de la cuenta
                        // Por ahora solo un snackbar para demo
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Ver detalles de "${cuenta['nombre']}"',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.visibility,
                        color: AppColors.primary,
                        size: 28,
                      ),
                      tooltip: 'Ver cuenta',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavWithAdd(
        onAddPressed: _agregarNuevaCuenta,
      ),
    );
  }
}

class CustomBottomNavWithAdd extends StatelessWidget {
  final VoidCallback onAddPressed;

  const CustomBottomNavWithAdd({super.key, required this.onAddPressed});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: Icons.home,
              label: "Inicio",
              onTap: () => Navigator.pushNamed(context, '/home'),
            ),
            _buildNavItem(
              icon: Icons.add,
              label: "Agregar",
              onTap: onAddPressed,
            ),
            _buildNavItem(
              icon: Icons.menu,
              label: "Menú",
              onTap: () => Navigator.pushNamed(context, '/menu'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 25),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(color: AppColors.primary, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
