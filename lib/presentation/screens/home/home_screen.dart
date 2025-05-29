// lib/presentation/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'components/balance_card.dart'; // Para BalanceCard
import 'components/quick_actions.dart'; // Para QuickActionsPanel
import 'components/transaction_list.dart'; // Para TransactionsList

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      body: CustomScrollView(
        slivers: [
          // App Bar personalizada
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.backgroundGradient,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Saludo de bienvenida
                      Text(
                        'Bienvenido,',
                        style: TextStyle(
                          color: AppColors.cream,
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Usuario Lukko',
                        style: TextStyle(
                          color: AppColors.cream,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black.withAlpha(77),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Contenido principal
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Aquí van los componentes del home
                const BalanceCard(),
                const SizedBox(height: 24),
                const QuickActionsPanel(),
                const SizedBox(height: 24),
                const TransactionsList(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
