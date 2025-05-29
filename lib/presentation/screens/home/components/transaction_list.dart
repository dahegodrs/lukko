// lib/presentation/screens/home/components/transaction_list.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            'Últimas transacciones',
            style: TextStyle(color: AppColors.cream, fontSize: 18),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          separatorBuilder: (_, __) => const Divider(color: AppColors.darkGrey),
          itemBuilder: (_, index) => ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: index.isEven
                    ? AppColors.lime.withAlpha(51)
                    : AppColors.teal.withAlpha(51),
                shape: BoxShape.circle,
              ),
              child: Icon(
                index.isEven ? Icons.arrow_upward : Icons.arrow_downward,
                color: index.isEven ? AppColors.lime : AppColors.teal,
              ),
            ),
            title: Text(
              index.isEven ? 'Salario mensual' : 'Pago de internet',
              style: TextStyle(color: AppColors.cream),
            ),
            subtitle: Text(
              index.isEven ? 'Ingreso' : 'Gasto fijo',
              style: TextStyle(color: AppColors.cream.withAlpha(153)),
            ),
            trailing: Text(
              index.isEven ? '+\$1,200' : '-\$45.99',
              style: TextStyle(
                color: index.isEven ? AppColors.lime : AppColors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
