import 'package:flutter/material.dart';

class FinancialSummaryCard extends StatelessWidget {
  const FinancialSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                const Text(
                  'LUKKO Balance',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD4AF37), // Dorado metálico
                    letterSpacing: 1.5,
                  ),
                ),
                Image.asset(
                  'assets/images/mastercard.png',
                  width: 40,
                  height: 40,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Cupo total disponible
            Row(
              children: const [
                Text(
                  "Cupo total disponible:",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  "\$4.500.000",
                  style: TextStyle(
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
              children: const [
                Text(
                  "Deuda total actual:",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  "\$1.200.000",
                  style: TextStyle(
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
                    style: TextStyle(
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
                  iconSize: 24, // puedes ajustar tamaño si quieres
                  padding: EdgeInsets
                      .zero, // quita padding extra para que quede pegado al texto
                  constraints:
                      const BoxConstraints(), // elimina constraints extras para compactar
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
