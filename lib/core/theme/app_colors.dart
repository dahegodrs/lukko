// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

abstract class AppColors {
  // Paleta principal
  static const Color darkGrey = Color(0xFF7E7D82); // #545454 (Fondo principal)
  static const Color mutedGreen = Color(
    0xFF7B8A84,
  ); // #7b8a84 (Elementos secundarios)
  static const Color teal = Color(0xFF7E7D82); // #8cbfaf (Acentos)
  static const Color cream = Color(0xFFD6D5D7); // #ede7d5 (Textos/Highlights)
  static const Color lime = Color(0xFF7E7D82); // #b7cc18 (Botones primarios)
  static const Color aguamarina = Color(0xFF01d1db); // Acento
  static const Color lightcoral = Color(0xFFF08080); // Acento

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [darkGrey, Color(0xFF424242)],
    stops: [0.0, 0.6],
  );

  static const Color textPrimary = cream;
  static const Color textSecondary = mutedGreen;
  static const Color primary = lime;
  static const Color secondary = teal;
}
