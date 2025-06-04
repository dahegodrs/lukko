import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/icon/lukko_home.png', height: 60),
          const CircleAvatar(
            radius: 20, // Ajusta el tamaño del círculo
            backgroundColor: AppColors.textPrimary,
            child: Icon(
              Icons.person,
              color: Colors.grey,
              size: 30, // Ajusta el tamaño del ícono dentro del círculo
            ),
          ),
        ],
      ),
    );
  }
}
