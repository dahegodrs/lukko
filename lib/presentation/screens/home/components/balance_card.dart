// lib/presentation/screens/home/components/balance_card.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkGrey.withAlpha(179),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.teal.withAlpha(77)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(77),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Balance Total',
            style: TextStyle(
              color: AppColors.cream.withAlpha(204),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '\$12,450.75',
            style: TextStyle(
              color: AppColors.cream,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildIncomeExpense(
                label: 'Ingresos',
                amount: '\$3,200',
                color: AppColors.lime,
              ),
              _buildIncomeExpense(
                label: 'Gastos',
                amount: '\$1,850',
                color: AppColors.teal,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeExpense({
    required String label,
    required String amount,
    required Color color,
  }) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: AppColors.cream.withAlpha(179))),
        const SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
