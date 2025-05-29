// lib/routes/app_router.dart
import 'package:flutter/material.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/transactions/add_transaction_screen.dart';
import '../../../core/theme/app_colors.dart';

class AppRouter {
  // Definimos rutas como constantes
  static const String login = '/';
  static const String home = '/home';
  static const String addTransaction = '/add-transaction';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case addTransaction:
        return MaterialPageRoute(builder: (_) => const AddTransactionScreen());
      default:
        return _errorRoute(settings.name ?? 'unknown');
    }
  }

  static Route<dynamic> _errorRoute(String routeName) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Text(
            'Ruta "$routeName" no encontrada',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: AppColors.darkGrey,
      ),
    );
  }
}
