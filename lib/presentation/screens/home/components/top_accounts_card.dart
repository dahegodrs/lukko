import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lukko/core/theme/app_colors.dart';
import 'package:lukko/presentation/blocs/cuentas_provider.dart';

class TopAccountsCard extends StatelessWidget {
  const TopAccountsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cuentas = Provider.of<CuentasProvider>(context).cuentas.toList()
      ..sort((a, b) => (b.cupo - b.deuda).compareTo(a.cupo - a.deuda));

    final top3 = cuentas.take(3).toList();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      elevation: 3,
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
            ...top3.map((cuenta) {
              final double porcentajeDisponible =
                  (cuenta.cupo - cuenta.deuda) / cuenta.cupo;
              final int porcentajeInt = (porcentajeDisponible * 100)
                  .clamp(0, 100)
                  .toInt();

              Color progressColor;
              if (porcentajeDisponible >= 0.66) {
                progressColor = Colors.green;
              } else if (porcentajeDisponible >= 0.33) {
                progressColor = Colors.orange;
              } else {
                progressColor = Colors.red;
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.account_balance_wallet,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            cuenta.nombre,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(
                            begin: 0,
                            end: (cuenta.cupo - cuenta.deuda).toDouble(),
                          ),
                          duration: const Duration(milliseconds: 700),
                          builder: (context, value, child) {
                            return Text(
                              '\$${value.toInt().toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        '$porcentajeInt% disponible',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: progressColor,
                        ),
                      ),
                    ),
                    LinearProgressIndicator(
                      value: porcentajeDisponible,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                      minHeight: 6,
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
