// lib/main.dart
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_router.dart'; // Importa el router

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      initialRoute:
          AppRouter.login, // Usa la ruta inicial definida en AppRouter
      onGenerateRoute:
          AppRouter.generateRoute, // Configura el generador de rutas
    );
  }
}
