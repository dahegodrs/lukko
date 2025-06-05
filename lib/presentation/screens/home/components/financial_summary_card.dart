import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lukko/presentation/blocs/cuentas_provider.dart';

class FinancialSummaryCard extends StatelessWidget {
  const FinancialSummaryCard({super.key});

  String _formatearMoneda(int valor) {
    return '\$${valor.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    final cuentasProvider = context.watch<CuentasProvider>();
    final cupoTotal = cuentasProvider.sumaCupo;
    final deudaTotal = cuentasProvider.sumaDeuda;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF0D0D0D), Color(0xFF1A1A1A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Lukko + Premium
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lukko Balance',
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  child: const Text(
                    'PREMIUM',
                    style: TextStyle(
                      color: Color(0xFFA8A8A8),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Cupo total disponible
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
                  _formatearMoneda(cupoTotal),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Deuda total actual
            Row(
              children: [
                const Text(
                  "Deuda total actual:",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  _formatearMoneda(deudaTotal),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Chip y número de tarjeta
            Row(
              children: [
                Image.asset('assets/images/chip.png', width: 36, height: 36),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '4567 8910 1123 4594',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/account-list');
                  },
                  icon: const Icon(Icons.remove_red_eye_outlined),
                  color: Colors.white70,
                  iconSize: 24,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
