// lib/presentation/widgets/shared/custom_app_bar.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: AppTextStyles.headlineSmall),
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.cream),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      backgroundColor: AppColors.darkGrey,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.cream),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
