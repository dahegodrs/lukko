import 'package:flutter/material.dart';
import 'package:lukko/core/theme/app_colors.dart';

class TopAccountsCard extends StatelessWidget {
  const TopAccountsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final accounts = [
      {"nombre": "Cuenta Nómina", "cupo": "\$3.000.000"},
      {"nombre": "Cuenta Ahorros", "cupo": "\$1.000.000"},
      {"nombre": "Cuenta Corriente", "cupo": "\$2.500.000"},
    ];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Top 3 cuentas con más cupo",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
            ...accounts.map(
              (acc) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Text(
                      acc['nombre']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.primary,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      acc['cupo']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
