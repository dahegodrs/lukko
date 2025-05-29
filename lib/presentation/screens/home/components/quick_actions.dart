import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../routes/app_router.dart';

class QuickActionsPanel extends StatelessWidget {
  const QuickActionsPanel({super.key});

  final List<Map<String, dynamic>> actions = const [
    {'icon': Icons.add, 'label': 'Agregar', 'color': AppColors.teal},
    {'icon': Icons.money_off, 'label': 'Gasto', 'color': AppColors.lime},
    {'icon': Icons.money, 'label': 'Ingreso', 'color': AppColors.teal},
    {'icon': Icons.pie_chart, 'label': 'Reportes', 'color': AppColors.lime},
  ];

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 130, // Previene overflow
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.85, // Mejor relación de aspecto
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: actions.length,
        itemBuilder: (_, index) => _buildActionItem(context, index),
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, int index) {
    final action = actions[index];
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () => _handleAction(context, index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: action['color'].withAlpha(40),
                shape: BoxShape.circle,
                border: Border.all(
                  color: action['color'].withAlpha(153), // 60% opacity
                  width: 1.5,
                ),
              ),
              padding: const EdgeInsets.all(14),
              child: Icon(
                action['icon'] as IconData,
                color: AppColors.cream,
                size: 24,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              action['label'] as String,
              style: TextStyle(
                color: AppColors.cream.withAlpha(230), // 90% opacity
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _handleAction(BuildContext context, int index) {
    debugPrint('Action tapped: $index'); // Para debug

    switch (index) {
      case 0: // Agregar
        Navigator.pushNamed(context, AppRouter.addTransaction)
            .then((_) => debugPrint('Navigation complete'))
            .catchError((e) => debugPrint('Error: $e'));
        break;
      case 1: // Gasto
        Navigator.pushNamed(
          context,
          AppRouter.addTransaction,
          arguments: {'isExpense': true},
        );
        break;
      case 2: // Ingreso
        Navigator.pushNamed(
          context,
          AppRouter.addTransaction,
          arguments: {'isExpense': false},
        );
        break;
      case 3: // Reportes
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Módulo de reportes en desarrollo'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.teal,
          ),
        );
        break;
    }
  }
}
